#!/usr/bin/env python
# Credit and thanks to CorpNewt, where functions originate from
import os, subprocess, shlex, datetime, sys, pprint

def run_command(comm, shell = False):
    c = None
    try:
        if shell and type(comm) is list:
            comm = " ".join(shlex.quote(x) for x in comm)
        if not shell and type(comm) is str:
            comm = shlex.split(comm)
        p = subprocess.Popen(comm, shell=shell, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        c = p.communicate()
        return (c[0].decode("utf-8", "ignore"), c[1].decode("utf-8", "ignore"), p.returncode)
    except:
        if c == None:
            return ("", "Command not found!", 1)
        return (c[0].decode("utf-8", "ignore"), c[1].decode("utf-8", "ignore"), p.returncode)

def cls():
   	os.system('cls' if os.name=='nt' else 'clear')

def get_XHC(XHC):
    # First split up the text and find the device
    try:
        hid = "XHC@" + XHC.split("XHC@")[1].split()[0]
    except:
        return None
    # Got our XHC address - get the full info
    hd = run_command(["ioreg", "-p", "IODeviceTree", "-n", hid])[0]
    if not len(hd):
        return None
    primed = False
    hdevice = {"name":"Unknown", "parts":{}}
    for line in hd.split("\n"):
        if not primed and not "XHC@" in line:
            continue
        if not primed:
            # Has XHC
            try:
                hdevice["name"] = "XHC@" + line.split("XHC@")[1].split()[0]
            except:
                hdevice["name"] = "Unknown"
            primed = True
            continue
        # Primed, but not XHC
        if "+-o" in line:
            # Past our prime
            primed = False
            continue
        # Primed, not XHC, not next device - must be info
        try:
            name = line.split(" = ")[0].split('"')[1]
            hdevice["parts"][name] = line.split(" = ")[1]
        except Exception as e:
            pass
    return hdevice

def ptrunc(text, length = "@"):
    if len(text) > length:
        text = text[:length-3]+"..."
    print(text)

def main():
    max_length = "@"
    ioreg = run_command(["ioreg"])
    if not len(ioreg[0]):
        print("IOReg error!")
        exit(1)
    XHC = []
    for line in ioreg[0].split("\n"):
        if "XHC" in line:
            XHC.append(line)
    if not len(XHC):
        print("XHC not found!")
        exit(1)
    # Iterate through our XHCs and get the info
    hlist = []
    for h in XHC:
        d = get_XHC(h)
        if d:
            hlist.append(d)
    # Print!
    for h in hlist:
        # Get the PciRoot location
        try:
            locs = h['name'].split("@")[1].split(",")
            loc = "PciRoot(0x0)/Pci(0x{},0x{})".format(locs[0],locs[1])
        except:
            loc = None
            pass
        if loc:
            print("{} - {}:\n".format(h['name'], loc))
        else:
            print("{}:\n".format(h['name']))
        # Get the longest key
        longest = len(map(len, h['parts']))
        for k in h["parts"]:
            v = h['parts'][k]
            ptrunc("{} = {}".format(" "*(longest-len(k))+k, v))
        print("")


if __name__ == '__main__':
    main()