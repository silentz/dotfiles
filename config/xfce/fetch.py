import argparse
import os
import xml.etree.ElementTree
from typing import Any, Dict


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

    return result


def read_xfconf_channel(name: str, path: str) -> Dict[str, Any]:
    with open(path, "r") as file:
        data = file.read()

    tree = xml.etree.ElementTree.fromstring(data)
    result_map = traverse_property_map(tree)

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
