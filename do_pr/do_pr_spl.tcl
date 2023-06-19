set init_lef_file ../../../0_FreePDK45/LEF/NangateOpenCellLibrary.lef
set init_gnd_net VSS
set init_pwr_net VDD

set init_verilog ../gate/my_adder.v
set init_top_cell my_adder

init_design
floorPlan  -r 1 0.7 3.0 3.0 3.0 3.0
setPlaceMode -placeIOPins 1
placeDesign -noPrePlaceOpt  
addFiller -cell FILLCELL_X8 FILLCELL_X4 FILLCELL_X2 FILLCELL_X1 -prefix FILLER
routeDesign -globalDetail
verify_drc   -report reports/my_adder.drc
verify_connectivity -report reports/my_adder.connect
streamOut results/my_adder.gds -mapFile streamOut.map -libName my_library -units 2000 -mode ALL
