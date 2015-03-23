# mic-timer-hue
Use Philips Hue lights to alert people in a microphone line that their time is up

# Installation

    npm install mic-timer-hue

# Usage

Push the button on your Hue gateway.  Run `miket`; it will tell you an IP
address and user number.  Use those the next time you run `miket`, either on
the command line or by specifying a .json filename with `-f`.

    miket [options]

    Options:

      -h, --help             output usage information
      -i --ip [address]      IP address
      -n --num [usernumber]  User number
      -w --warn [secs]       Warn with [secs] left
      -t --time [secs]       Total time to allow
      -f --file [filename]   filename for .json args

## Keyboard interface

* space: (re-)start timer
* c: clear
* q: quit

# License

(BSD 2-Clause)

Copyright (c) 2015, Joe Hildebrand
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
