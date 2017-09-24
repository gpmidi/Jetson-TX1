// Variables 
// in mm
include <MCAD/nuts_and_bolts.scad>;

// Screw size in Mn
screwSize=4;
screwFactor=1.3;
// Internal dimensions
internalX=190; // or 180
internalY=190; // or 180
internalZ=70;
// How thick all walls are
wallThickness=5; // or 3
// External dimensions
externalX=internalX+(wallThickness*2);
echo("ExternalX: ",externalX);
externalY=internalY+(wallThickness*2);
echo("ExternalY: ",externalY);
externalZ=internalZ+(wallThickness*2);
echo("ExternalZ: ",externalZ);
// Board dimensions
boardX=170.2;
boardY=170.2;
boardZ=15.58;
boardZCPU=40;
// Hight of the screw holes / Space between bottom of 
// pcb and interiour bottom of case
screwHeight=10;
// Space between board and interrior wall
bufferX=(internalX-boardX)/2;
bufferY=(internalY-boardY)/2;
// PCB Starting points
boardStartX=wallThickness+bufferX;
boardStartY=wallThickness+bufferY;
// Z height of the bottom of the PCB
pcbBottomZ=wallThickness+screwHeight;
// Z height of where the top-of-pcb plug holes should start
plugHolesStartZ=pcbBottomZ-2;
// Z height of where the CPU parts end (except for CPU)
componentTopZ=pcbBottomZ+boardZ;
// Z height of where the CPU heatsink ends
CPUTopZ=pcbBottomZ+boardZCPU;
// Screw hole outer radius
screwHoleOuterRadius=6.45/2+3;

// Buttons
buttonOuterWidth=44.97;
buttonExtra=7;
buttonHoleY=buttonOuterWidth+(buttonExtra*2);
buttonHoleZ=25;

// Camera
cameraWidth=21.51;
cameraHeight=25;
cameraStartX=boardStartX+92.2;
cameraStartZ=pcbBottomZ;

// Main I/O
ioMainStartY=boardStartY+10;
ioMainStartZ=plugHolesStartZ;
ioMainWidth=160;
ioMainHeight=25;

// Top & Bottom vents
ventLength=50;
ventWidth=5;
ventStartX=40;
ventStartY=40;
ventEndX=boardStartX+boardX-ventLength;
ventEndY=boardStartY+boardY-(ventStartY/2);

// Top Mount Spots
lidMountX=15;
lidMountY=15;
lidMountZ=10;
lidTolerance=-0.1;

// Mid mounts
midMountMiddleZ=pcbBottomZ+cameraHeight;
midMountHeightZ=15+cameraHeight+pcbBottomZ;

difference() {
    union() {
        // Top Section
        *union() {
            translate([wallThickness+lidTolerance,wallThickness+lidTolerance,externalZ-wallThickness])
                cube([externalX-wallThickness*2,externalY-wallThickness*2,wallThickness]);
        };
        // The space the TX1 will require AT A MINIMUM!
        *union() {
            translate([boardStartX,boardStartY,pcbBottomZ])
                cube([boardX,boardY,boardZCPU]);
        };
        // Botom Section
        union() {
            // bottom panel
            cube([externalX,externalY,wallThickness]);

            // Side
            translate([0,0,0])
                cube([wallThickness,externalY,externalZ]);
            
            // Side
            translate([0,0,0])
                cube([externalX,wallThickness,externalZ]);
            
            // Side 
            translate([externalX-wallThickness,0,0])
                cube([wallThickness,externalY,externalZ]);
            
            // Side 
            translate([0,externalY-wallThickness,0])
                cube([externalX,wallThickness,externalZ]);

            // Screw Hole - Upper left
            translate([boardStartX+10.18,boardStartY+6.35,wallThickness+(screwHeight/2)])
                cylinder(r=screwHoleOuterRadius,h=screwHeight,center=true);
            
            // Screw Hole - Upper Right
            translate([boardStartX+33.02,boardStartY+163.83,wallThickness+(screwHeight/2)])
                cylinder(r=screwHoleOuterRadius,h=screwHeight,center=true);
                
            // Screw Hole - Lower left
            translate([boardStartX+165.10,boardStartY+6.35,wallThickness+(screwHeight/2)])
                cylinder(r=screwHoleOuterRadius,h=screwHeight,center=true);
            
            // Screw Hole - Lower Right
            translate([boardStartX+165.10,boardStartY+163.84,wallThickness+(screwHeight/2)])
                cylinder(r=screwHoleOuterRadius,h=screwHeight,center=true);
                
            // Top Mount - Upper Left
            translate([0,0,externalZ-(lidMountZ*1.5)])
                cube([lidMountX,lidMountY,lidMountZ]);
            
            // Top Mount - Upper Right
            translate([0,externalY-lidMountY,externalZ-(lidMountZ*1.5)])
                cube([lidMountX,lidMountY,lidMountZ]);
            
            // Top Mount - Lower Left
            translate([externalX-lidMountX,0,externalZ-(lidMountZ*1.5)])
                cube([lidMountX,lidMountY,lidMountZ]);
            
            // Top Mount - Lower Right
            translate([externalX-lidMountX,externalY-lidMountY,externalZ-(lidMountZ*1.5)])
                cube([lidMountX,lidMountY,lidMountZ]);
        };
    };
    // Stuff to remove from sides/top/bottom
    union() {
        // Buttons at bottom left
        translate([externalX-wallThickness-0.001,boardStartY+15.37-buttonExtra,plugHolesStartZ])
            cube([wallThickness+0.002,buttonHoleY,buttonHoleZ]);
        
        // Camera on right side
        translate([cameraStartX,externalY-wallThickness-0.001,cameraStartZ])
            cube([cameraWidth,wallThickness+0.002,cameraHeight]);
        
        // Main I/O panel on top
        translate([0-0.001,ioMainStartY,ioMainStartZ])
            cube([wallThickness+0.002,ioMainWidth,ioMainHeight]);
    
        // Bottom Slots
        for (x=[ventStartX:ventLength+20:ventEndX]) {    
            for (y=[ventStartY:ventWidth*2:ventEndY]) {      
                translate([x,y,0-0.001])
                    cube([ventLength,ventWidth,wallThickness+0.002]);
            };
        };
        
        // Top Slots
        for (x=[ventStartX:ventLength+20:ventEndX]) {    
            for (y=[ventStartY:ventWidth*2:ventEndY]) {      
                translate([x,y,externalZ-wallThickness-0.001])
                    cube([ventLength,ventWidth,wallThickness+0.002]);
            };
        };
        
         // Screw Hole - Upper left
        translate([boardStartX+10.18,boardStartY+6.35,externalZ-(wallThickness/2)])
            cylinder(r=screwHoleOuterRadius,h=wallThickness+0.002,center=true);
        
        // Screw Hole - Upper Right
        translate([boardStartX+33.02,boardStartY+163.83,externalZ-(wallThickness/2)])
            cylinder(r=screwHoleOuterRadius,h=wallThickness+0.002,center=true);
            
        // Screw Hole - Lower left
        translate([boardStartX+165.10,boardStartY+6.35,externalZ-(wallThickness/2)])
            cylinder(r=screwHoleOuterRadius,h=wallThickness+0.002,center=true);
        
        // Screw Hole - Lower Right
        translate([boardStartX+165.10,boardStartY+163.84,externalZ-(wallThickness/2)])
            cylinder(r=screwHoleOuterRadius,h=screwHeight,center=true);
        
        // Spot for M4 nuts and bolts
        translate([boardStartX+10.18,boardStartY+6.35,-0.001])
            nutHole(screwSize);
        translate([boardStartX+10.18,boardStartY+6.35,-0.001])
            boltHole(screwSize,length=wallThickness+screwHeight+0.002);
            
        translate([boardStartX+33.02,boardStartY+163.83,-0.001])
            nutHole(screwSize);
        translate([boardStartX+33.02,boardStartY+163.83,-0.001])
            boltHole(screwSize,length=wallThickness+screwHeight+0.002);
            
        translate([boardStartX+165.10,boardStartY+6.35,-0.001])
            nutHole(screwSize);
        translate([boardStartX+165.10,boardStartY+6.35,-0.001])
            boltHole(screwSize,length=wallThickness+screwHeight+0.002);        
            
        translate([boardStartX+165.10,boardStartY+163.84,-0.001])
            nutHole(screwSize);
        translate([boardStartX+165.10,boardStartY+163.84,-0.001])
            boltHole(screwSize,length=wallThickness+screwHeight+0.002);
            
            
        // Top - Spot for M4 nuts and bolts - Upper Left
        translate([wallThickness+lidMountX-METRIC_NUT_AC_WIDTHS[screwSize]*screwFactor,wallThickness+lidMountY-METRIC_NUT_AC_WIDTHS[screwSize]*screwFactor,externalZ-wallThickness-lidMountZ]) {
            nutHole(screwSize);
            boltHole(screwSize,length=wallThickness+screwHeight+0.002);
        }
        
        // Top - Spot for M4 nuts and bolts - Lower Left
        translate([externalX-(wallThickness+lidMountX-METRIC_NUT_AC_WIDTHS[screwSize]*screwFactor),wallThickness+lidMountY-METRIC_NUT_AC_WIDTHS[screwSize]*screwFactor,externalZ-wallThickness-lidMountZ]) {
            nutHole(screwSize);
            boltHole(screwSize,length=wallThickness+screwHeight+0.002);
        }
        
        // Top - Spot for M4 nuts and bolts - Upper Right
        translate([wallThickness+lidMountX-METRIC_NUT_AC_WIDTHS[screwSize]*screwFactor,externalY-(wallThickness+lidMountY-METRIC_NUT_AC_WIDTHS[screwSize]*screwFactor),externalZ-wallThickness-lidMountZ]) {
            nutHole(screwSize);
            boltHole(screwSize,length=wallThickness+screwHeight+0.002);
        }
        
        // Top - Spot for M4 nuts and bolts - Lower Right
        translate([externalX-(wallThickness+lidMountX-METRIC_NUT_AC_WIDTHS[screwSize]*screwFactor),externalY-(wallThickness+lidMountY-METRIC_NUT_AC_WIDTHS[screwSize]*screwFactor),externalZ-wallThickness-lidMountZ]) {
            nutHole(screwSize);
            boltHole(screwSize,length=wallThickness+screwHeight+0.002);
        }
            
        // For Side A
        *translate([externalX/2,-0.001,-0.001])
            cube([externalX/2+5,externalY+5,externalZ+5]);
        
        // For Side B
        *translate([-0,001,-0.001,-0.001])
            cube([externalX/2+5,externalY+5,externalZ+5]);
    };
    
    *translate([-0.001,-0.001,ioMainStartZ+ioMainHeight]) 
        //mirror([0,0,1])  // Comment this out to enable top
        cube([5000,5000,5000]);
};
