#!/usr/bin/python

'''
parse_results.py : 	Python script to process results files (xml) into csv files. The current version doesn't
					output all of the data but can be trivially extended to print out all of the parameters.
					
Created on 22 May 2014

@author: Dominic Giles
'''

from xml.dom import minidom
import argparse
import sys
import os
import operator


def getValueFromDoc(document, elementName):
    list = document[1].getElementsByTagName(elementName)
    if len(list) != 0:
        return list[0].firstChild.data
    else:
        return None

def getValueFromElement(element, elementName):
    list = element.getElementsByTagName(elementName)
    if len(list) != 0:
        return list[0].firstChild.data
    else:
        return None


parser = argparse.ArgumentParser(description='Swingbench results file processor')
parser.add_argument("-r", "--resultfile", help="The name of the resultfile to parse", required=True, nargs='*')
parser.add_argument("-o", "--outputfile", help="")
args = parser.parse_args()

xmlfiles = args.resultfile
outFileName = args.outputfile

if outFileName is None:
    output = sys.stdout
else:
    output = file(outFileName, 'w')

xmldocs = {}

for fileToParse in xmlfiles:
    xmldocs[os.path.basename(fileToParse)] = minidom.parse(fileToParse)

sortedxmldocs = sorted(xmldocs.iteritems(), key=operator.itemgetter(0))  # Sort the results

output.write('Metric, ')
for doc in sortedxmldocs:
    output.write(doc[0] + ", ")
output.write('\n')

output.write('AverageTransactionsPerSecond, ')
for doc in sortedxmldocs:
    output.write(str(getValueFromDoc(doc, 'AverageTransactionsPerSecond')) + ", ")
output.write('\n')

output.write('MaximumTransactionRate, ')
for doc in sortedxmldocs:
    output.write(str(getValueFromDoc(doc, 'MaximumTransactionRate')) + ", ")
output.write('\n')

output.write('AverageUserCPU, ')
for doc in sortedxmldocs:
    output.write(str(getValueFromDoc(doc, 'AverageUsrCPU')) + ", ")
output.write('\n')

itemlist = sortedxmldocs[0][1].getElementsByTagName('Result')
for item in itemlist:
    output.write(item.attributes["id"].value + ', ')  # Get the transaction we are after

    for doc in sortedxmldocs:  # Get an xmldoc
        itemlist2 = doc[1].getElementsByTagName('Result')
        for item2 in itemlist2:
            if (item2.attributes["id"].value == item.attributes["id"].value):
                output.write(str(getValueFromElement(item2, 'AverageResponse')) + ', ')
    output.write('\n')
