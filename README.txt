This solver is based on the OpenFOAM solver compressibleInterFoam, created by Max Koch, Christiane Lechner, and Qingyun Zeng and modified by Hendrik Reese.
Its purpose is to model the first oscillation cycles of a single laser-induced cavitation bubble near a rigid boundary.

To run a simulation, one must first properly install OpenFOAM-4.0:
https://openfoam.org/version/4-0/

In the following instructions it is assumed that OpenFOAM was installed on an Ubuntu operating system.
To execute OpenFOAM commands, one must first enter the OpenFOAM environment by 
executing the alias command for the installed OpenFOAM version (usually 'of4'),
which has to have been sourced after OpenFOAM installation.

1. Extract both folders "CavBubbleFoam" and "exampleCase" in any location.
2. Open a terminal in "CavBubbleFoam" and compile it via 'wmake'.
3. Extract "exampleCase/canalorg/canall1000w50.zip".
4. Run the simulation by executing './Allrun' for serial computation or './AllrunPar' for parallel computation in "exampleCase/canalorg".
5. If executed in parallel computation, reconstruct the simulation data using 'reconstructPar'.
6. To view the simulation results, open the file fluid.foam using ParaView.

The progress of the simulation may be monitored by running 'tail -f log.CavBubbleFoam' in the simulation folder.
Simulation settings and parameters may be altered in the text files within the simulation folder (e.g. bubble initial conditions in "constant/transportProperties" or simulation end time and field output interval in "system/controlDict").
The simulation geometry may be altered by changing the file "exampleCase/canal.geo" and opening it using gmsh (https://gmsh.info/), meshing it in 3D, exporting it as a .msh file using Version 2 ASCII and replacing it with the .msh file in the simulation folder.