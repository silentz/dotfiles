import argparse
import os
import xml.etree.ElementTree
from typing import Any, Callable, Dict


def filter_out_empty_key_values(data: dict):
    result = dict()
    for k, v in data.items():
        if v:
            result[k] = v
    return result


PATCH_MAP_CONFIG = {
    "xfce4-keyboard-shortcuts.xml": {
        "commands": {"default": None},
        "xfwm4": {
            "default": None,
            "custom": filter_out_empty_key_values,
        },
    }
}


def patch_map(data: Any, config: Any) -> Dict[Any, Any]:
    result = data.copy()

    for key, value in config.items():
        if key not in data:
            continue

        if value is None:
            result.pop(key)
        elif isinstance(value, dict):
            result[key] = patch_map(data[key], config[key])
        elif isinstance(value, Callable):
            result[key] = value(data[key])

    return result


def traverse_property_map(elem: xml.etree.ElementTree.Element) -> Dict[Any, Any]:
    result = dict()

    if elem.tag == "channel":
        for child in elem:
            child_map = traverse_property_map(child)
            result.update(child_map)

    elif elem.tag == "property":
        prop_type = elem.attrib.get("type")
        prop_name = elem.attrib.get("name")
        prop_value = elem.attrib.get("value")

        if prop_type == "empty":
            for child in elem:
                child_map = traverse_property_map(child)
                result.update(child_map)
            result = {prop_name: result}
        elif prop_type == "array":
            items = [traverse_property_map(x) for x in elem]
            result[prop_name] = items
        elif prop_type in {"string", "int", "bool", "double", "uint"}:
            result[prop_name] = prop_value
        else:
            raise ValueError(f"unknown property type: {prop_type}")

    elif elem.tag == "value":
        return elem.get("value")  # type: ignore

    return result


def read_xfconf_channel(name: str, path: str) -> Dict[str, Any]:
    with open(path, "r") as file:
        data = file.read()

    tree = xml.etree.ElementTree.fromstring(data)
    result_map = traverse_property_map(tree)

    if name in PATCH_MAP_CONFIG:
        result_map = patch_map(result_map, PATCH_MAP_CONFIG[name])

    return result_map


def fetch_xfconf(root: str, subdir: str) -> Dict[str, Any]:
    conf_root = os.path.join(root, subdir)
    conf_files = [x for x in os.listdir(conf_root)]
    conf_files = {x: os.path.join(conf_root, x) for x in conf_files}
    conf_files = {x: y for x, y in conf_files.items() if y.endswith(".xml")}
    conf_files = {x: read_xfconf_channel(x, y) for x, y in conf_files.items()}
    return conf_files


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--xfce", type=str, default="~/.config/xfce4")

    args = parser.parse_args()
    args.xfce = os.path.expanduser(args.xfce)
    args.xfce = os.path.expandvars(args.xfce)

    xfconf = fetch_xfconf(args.xfce, "xfconf/xfce-perchannel-xml")
    print(xfconf)
