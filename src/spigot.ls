parseMethod = (node) -> 
    result = ''
    for child in node.children
        switch child.nodeName
        case 'console'
            result += '        System.out.println(' + child.innerHtml + ');\n'
        default
            result = 'Unexpected token ' + child.nodeName
    result

parsePlugin = (node) ->
    result = ''
    for child in node.children
        switch child.nodeName
        case 'ONENABLE'
            result += '    public function onEnable()\n    {\n' + parseMethod(child) + '    }\n'
        case 'ONDISABLE'
            result += '    public function onDisable()\n    {\n' + parseMethod(child) + '    }\n'
        default
            result = 'Unexpected token ' + child.nodeName
    result

plugins = document.getElementsByTagName('plugin')

result = '<pre>'

for plugin in plugins
    result += 'public class Main extends Javaplugin\n{\n' + parsePlugin(plugin) + '}</pre>'

document.write(result)
