#!/bin/bash
sudo netstat -an | grep TIME_WAIT | wc -l
