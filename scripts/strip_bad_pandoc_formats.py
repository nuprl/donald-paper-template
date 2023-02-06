import sys
import json
from typing import Any, List

in_f = sys.argv[1]
out_f = sys.argv[2]

with open(in_f, 'r') as in_file:
    in_json = json.load(in_file)

def strip_bad_format_toplevel(in_json):
    new_blocks = strip_bad_format_blocks_list(in_json['blocks'])
    in_json['blocks'] = new_blocks
    return in_json

def strip_bad_format_blocks_list(blocks_list) -> List[Any]:
    new_blocks_list = []
    for b in blocks_list:
        new_blocks_list += strip_bad_format_block(b)
    return new_blocks_list

def strip_bad_format_block(b) -> List[Any]:
    t = b['t']
    c = b['c'] if 'c' in b else None

    if t == 'SmallCaps':
        assert isinstance(c, List)
        return strip_bad_format_blocks_list(c)
    elif t == 'Quoted':
        assert isinstance(c, List)
        assert len(c) == 2
        quote_type_block = c[0]
        quote_body_blocks = c[1]
        replaced_c = [quote_type_block, strip_bad_format_blocks_list(quote_body_blocks)]
        return [{ "t": t, "c": replaced_c }]
    elif c is None:
        return [b]
    elif isinstance(c, str):
        return [b]
    elif isinstance(c, list):
        new_c = strip_bad_format_blocks_list(c)
        return [{"t": t, "c": new_c}]
    else:
        raise Exception("unhandled case!")

cleaned_json = strip_bad_format_toplevel(in_json)
with open(out_f, 'w') as out_file:
    json.dump(cleaned_json, out_file)

