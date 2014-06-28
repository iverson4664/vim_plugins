#!/usr/bin/env python

# steps
# 1. load file and contents into a tuple
# 2. pass file contents to libclang to parse an AST
# 3. search for member functions and variables
# 4. return a list of them to vim
# 5. highlight them sons of bitches!
# 6. ???
# 7. profit!!1

import sys
import clang.cindex
import vim

def clavim_init():
    global index
    index = Index.create()
    global translationUnits
    translationUnits = dict()
    global update
    update = False

def get_current_file():
    file = "\n".join(vim.eval("getline(1, '$')"))
    return (vim.current.buffer.name, file)

def get_current_translation_unit(update = False):
    current_file = get_current_file()
    filename = vim.current.buffer.name
    if filename in translationUnits:
        tu = translationUnits[filename]
        if update:
            tu.reparse([current_file])
        return tu

    tu = index.parse(filename)

    if tu is None:
        print 'Error: tu is None'
        return None

    translationUnits[filename] = tu
    tu.reparse([current_file])
    return tu

def cursorvisit_callback(node, parent, userdata):
    if node.kind == userdata['kind']:
        if node.extent.start.file is None:
            return 2
        my_node = dict()
        my_node['name'] = clang.cindex.Cursor_displayname(node)
        my_node['kind'] = node.kind.name
        my_node['file'] = node.extent.start.file.name
        my_node['line'] = node.location.line
        my_node['start'] = node.extent.start.column
        my_node['end'] = node.extent.end.column
        userdata['nodes'].append(my_node)
    return 2


def find_cursors(tu, kind):
    nodes = []
    userdata = dict()
            
    userdata['nodes'] = nodes
    userdata['kind'] = kind

    # visit children
    clang.cindex.Cursor_visit(
        tu.cursor,
        clang.cindex.Cursor_visit_callback(cursorvisit_callback),
        userdata)

    return nodes

def main():
    index = clang.cindex.Index.create()
    fname = sys.argv[1]
    tu    = index.parse(fname)
    kind  = clang.cindex.CursorKind.MEMBER_REF_EXPR
    nodes = find_cursors(tu, kind)

    print 'nodes (%s):' % (len(nodes))
    for x in nodes:
        print 'name=%s kind=%s file=%s line=%s start=%s end=%s' % (
            x['name'], 
            x['kind'], 
            x['file'], 
            x['line'], 
            x['start'],
            x['end'])
