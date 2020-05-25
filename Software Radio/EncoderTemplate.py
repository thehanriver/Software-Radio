import sys
import os
import time
import random
import zlib
import struct

import argparse

parser = argparse.ArgumentParser(description='Generate the messages for EC415 Lab6.')
parser.add_argument('filepath',
                    help='File path to write packet to.')
# parser.add_argument('grc_file', help='GRC file path that the program will compile and run.')
args = parser.parse_args()
filepath = args.filepath

print("File path = \"" + filepath + "\"")

def get_user_input(prompt="Enter a message: "):
    return raw_input(prompt)

def encode_hex(s):
    return s.encode('hex')

def generate_preamble(hex_str='AABBCCDD'):
    hex_num = int(hex_str,16)
    return struct.pack('>I', hex_num)

def generate_msg_length(msg):
    return struct.pack('>B', len(encode_hex(msg))%256)

def generate_crc(msg):
    crc = zlib.crc32(encode_hex(msg)) & 0xFFFFFFFF
    return struct.pack('>I', crc)

def write_packet_to_file(filename, packet):
    with open(filename, 'w') as f:
        f.write(packet)


""" ******************************************************* """
"""			Your Implementation Goes Below This Line		"""
""" ******************************************************* """

umessage = raw_input("Enter a message: ") #prompts user for message and gets the message
print 'your message: ',umessage

enc_hex = encode_hex(umessage) #encodes the message using hex
preamble = generate_preamble('AABBCCDD') #makes a preamble of AABBCCDD
length = generate_msg_length(umessage) #takes the message and retruns the length in hex encoded
crc = generate_crc(umessage) #generates CRC message from user
packet = preamble + length + enc_hex + crc #concatinates all compenentes together in respective order of preamble + length + message + crc all in encoded hex
write_packet_to_file(filepath,packet) #writes packet to file specified by user


"""

You have access to some useful variables and functions:
    get_user_input(prompt):
        Will display the string prompt to the user and return what they entered.

    encode_hex(s):
        Takes a string s and encodes it using hex.

    generate_preamble(hex_str):
        Takes a string composed of 8 hex characters and returns a set of bytes representing
        that string. For example, generate_preamble('AABBCCDD') return '\xAA\xBB\xCC\xDD'.

    generate_hex_msg_length(msg):
        Takes a ASCII string and returns the length of the hex encoded version of that
        string.

    generate_crc(msg):
        Takes an ASCII string and returns the CRC code for the hex encoded version of the string.

    write_packet_to_file(filename, packet):
        Writes a packet to the filename specified.
"""
