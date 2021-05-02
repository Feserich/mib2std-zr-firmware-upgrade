import configparser
import sys

# this script is a fork from MIB Solution 

if len(sys.argv) < 5:
    print ("Usage:", sys.argv[0], "<inputfile> <outputfile> <number for change> <number to change>")
    print ("Example: python3", sys.argv[0], "metainfo2.txt metainfo2_patched.txt 36 18")
    sys.exit()


inputfile = sys.argv[1]
outputfile = sys.argv[2]
for_change = "\\" + sys.argv[3] + "\\"
to_change = "\\" + sys.argv[4] + "\\"


#import configparser
input_config = configparser.ConfigParser()
input_config.optionxform=str
input_config.read(inputfile)

output_config = configparser.ConfigParser()
output_config.optionxform=str

for section in input_config.sections():
    if for_change in section:
        newsection = section.replace(for_change, to_change)
        output_config.add_section(section)
        for option in input_config.options(section):
            output_config.set(section, option, input_config.get(section, option))
        output_config.add_section(newsection)
        output_config.set(newsection, "Link", '"'+section+'"')
    else:
        output_config.add_section(section)
        for option in input_config.options(section):
            output_config.set(section, option, input_config.get(section, option))
    
    if input_config.has_option(section, "RequiredVersionOfDM"):
        output_config.set(section, "RequiredVersionOfDM", '"0"')

with open(outputfile, "w") as config_file:
    output_config.write(config_file)


print ("Done!")
