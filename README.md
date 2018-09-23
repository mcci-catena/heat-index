# NWS Heat Index Calculations

This repository has a grab-bag of calculators for the [Heat Index](https://www.weather.gov/safety/heat-index) as defined by the US National Weather Service. There's nothing unique here, except perhaps that the code is intended to be used as library functions in other programs.

<!-- TOC depthFrom:2 updateOnSave:true -->

- [Background Material](#background-material)
- [Test and Reference](#test-and-reference)
- [Library Routines and Test Harnesses](#library-routines-and-test-harnesses)
- [Updating the CSV Query](#updating-the-csv-query)
- [License, Acknowledgements, etc.](#license-acknowledgements-etc)

<!-- /TOC -->

## Background Material

As background info, we include [Lans Rothfusz' 1990 paper](ta_htindx.pdf) that defines the calculations we use (and gives background). We also include a [reference PDF](NWS-Heat-Index-Equation-20180923.pdf) of the NWS Heat Index Equation page from 2018-09-23, which defines additional corrections and refinements.

## Test and Reference

As a utility, we provide an Excel spreadsheet, [heat-index.xlsm](heat-index.xlsm). This opens to a table calculated using the NWS formulas. It also includes sheets for comparing a .csv file against the reference table.

## Library Routines and Test Harnesses

- Everybody loves Excel. We have a Visual Basic routine that can be used in your spreadsheets: [heat-index.vba](heat-index.vba). This version returns `#Value` for input values that are not part of the defined range.

- JavaScript: [heat-index.js](heat-index.js). This implementation returns `null` for input values that are out of the defined domain of the function, and also for output values that would be over 183.5 degrees F (because the tables online don't cover input compbinations in this range).

  To test, use Node.js and the test harness [test-heat-index.js](test-heat-index.js), as follows:

    ```console
    $ cat heat-index.js test-heat-index.js | node - >test-heat-index.csv
    ```

   Then open [heat-index.xslm](heat-index.xslm). Unfortunately, Excel doesn't keep relative paths, so you'll have to change the spreadsheet to point to the CSV file properly. See (#updating-the-csv-query). Once the input is correct, the sheet labeled `test-heat-index` will check the cvs values against the reference, and puts a summary at the top of the page ("All Match: TRUE" for success).

## Updating the CSV Query

- Open the spreadsheet.
- Switch to the `CSV-Query` sheet
- Switch to the `Query` tab (at the top -- it appears only when you open the `CSV-Query` sheet).
- Click `Edit`.
- The "Power Query Editor" appears in a new window.
- Make sure `Home` tab is selected, then click `Data Source Settings`
- Click `Change Source...`
- Edit the file path.
- Click `OK`, then click `CLose`.
- Close the Power Query window.
- Your data should now appear.

## License, Acknowledgements, etc.

This page is maintained by Terry Moore of [MCCI Corporation](http://www.mcci.com).

This material is released under the MIT license. The two PDFs are from US government websites and are therefore in the public domain.

Material was verified against a [chart](https://www.iweathernet.com/wxnetcms/wp-content/uploads/2015/07/heat-index-chart-relative-humidity-2.png) posted by [iweathernet.com](https://www.iweathernet.com).

MCCI is a registered trademark of MCCI Corporation.
