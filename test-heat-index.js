// test the heat-index.js function by iterating over the fully defined area

// the easy way to use this is to combine this with heat-index.js on the
// command line:
//
//      cat heat-index.js test-heat-index.js | node - > $TEMP/test-heat-index.csv
//
// Then open the csv file, copy/paste into test-heat-index.xlsx, and verify that 
// the array of "comparisons is all true.

var rh;
var t;

for (t = 128.0; t >= 76.0; t -= 2.0)
        {
        var sRow = "";
        if (t == 128.0)
                sRow += '"T/RH"';
        else
                sRow += t;
 
        for (rh = 4.0; rh <= 100.0; rh += 2.0)
                {
                // first row is titles
                if (t == 128.0)
                        sRow += ', ' + rh;
                else
                        {
                        var tHi = CalculateHeatIndex(t, rh);
                        if (tHi !== null)
                                sRow += ', ' + tHi;
                        else
                                sRow += ',';
                        }
                }
        
        console.log(sRow);
        }