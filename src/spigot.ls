/**
 * this is fine
 *
 * no its not
 *
 * TODO:
 * EVERYTHING
 * ERROR REPORTS
 * AND STUFF
 * OK
 */

parseMethod = (node) -> 
    result = ''
    for child in node.children
        switch child.nodeName
        case 'CONSOLE'
            console.log(child)
            result += 'System.out.println("' + child.innerText + '");'
        case 'VARIABLE'
            result += child.innerText # TODO, this is crap
        case 'BROADCAST'
            result += 'Bukkit.broadcastMessage("' + child.innerText + '");'
        case 'BR'
            result += '\n'
        default
            result = 'Unexpected token ' + child.nodeName
    result

parsePlugin = (node) ->
    result = ''
    commands = ''
    for child in node.children
        switch child.nodeName
        case 'ONENABLE'
            result += 'public void onEnable(){' + parseMethod(child) + '}'
        case 'ONDISABLE'
            result += 'public void onDisable(){' + parseMethod(child) + '}'
        case 'COMMAND'
            commands += 'if (command.getName().equalsIgnoreCase("' + child.attributes['name'] + '")){' + parseMethod(child) + '}'
        default
            result = 'Unexpected token ' + child.nodeName
    if commands
    then
        result += 'public bool onCommand(CommandSender sender, Command command, String label, String[] args){' + commands + '}'
    result

plugins = document.getElementsByTagName('plugin')

result = '<pre>'

for plugin in plugins
    result += 'public class Main extends Javaplugin{' + parsePlugin(plugin) + '}</pre>'

document.write(result)
