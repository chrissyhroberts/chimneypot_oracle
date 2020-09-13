#!/usr/bin/env python
import urllib
import sys

from PiLiteLib import PiLiteBoard, poll_for_updates, JSONPoll



def main():
    sink = PiLiteBoard()
    print(str(sys.argv[1]))
    sink.write(str(sys.argv[1]))


if __name__ == "__main__":
    main()

