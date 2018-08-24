Before you run it for the first time:
1) Install R by running R-3.3.2-win.exe. Make sure you install it to the default
   location.

Steps to run the program once R is installed:
1) Put the binary FAIMS data files for one run in a single folder.
2) Convert them using my faims_converter.bat tool.
3) Copy the example sampleNames.txt file into the folder, open it, delete the 
   contents, and enter the names of the samples you have run (including blanks) 
   into the file, with one sample per line.
4) Run the splitter by double clicking FAIMSSplitter.bat.
5) Enter the full path to the folder containing the FAIMS data when prompted.
6) Enter "asc" (without quotes) when prompted for an extension.
7) Let the program run
8) Enjoy your split files!

Troubleshooting:
The program will spit out words of wisdom if it hits a problem. It will also 
produce two graphs for debugging, showing the flow rate per run and the
assigned sample id per run (example output is included in this zip file). 
If a sample failed to run, causing a very long stretch of low flow rate 
where there should be a sample, delete the failed sample from sampleNames.txt 
and re-run the program.
