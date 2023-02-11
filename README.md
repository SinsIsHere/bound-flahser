# Bound Flasher

This is a project for my LSI Logic Design course, in which, I operate a string of LED to the predetermined requirements. Alongside Verilog and Xilinx Vivado for simulation, I also learned to use Cadence Genus to synthesize and optimized my RTL design.

System operation:

At the initial state, all lamps are OFF. If flick signal is ACTIVE (set 1), the flasher start operating:

- The lamps are turned ON gradually from lamp[0] to lamp[5].

- The lamps are turned OFF gradually from lamp[5] (max) to lamp[0] (min).

- The lamps are turned ON gradually from lamp[0] to lamp[10].

- The lamps are turned OFF gradually from lamp[10] (max) to lamp[5] (min).
 
- The lamps are turned ON gradually from lamp[5] to lamp[15].
 
- Finally, the lamps are turned OFF gradually from lamp[15] to lamp[0], return to initial state.

Additional condition:

- At each kickback point (lamp[5] and lamp[10]), if flick signal is ACTIVE, the lamps will turn OFF gradually again to the min lamp of the previous state, then continue operation as above description.

- For simple, kickback point is considered only when the lamps are turned ON gradually, except the first state.

The main module can be found in the file **Bound_Flasher.v**.

The simulation results can be found in **simulation_1.png** and **simulation_2.png**.

![simulation_1](https://user-images.githubusercontent.com/92133811/218253409-898f0fd8-0398-44bd-9729-874111217048.png)

![simulation_2](https://user-images.githubusercontent.com/92133811/218253413-4de39c81-ccc0-44ba-af76-cc5562a2277e.png)

Also, using Cadence Genus Synthesis Solution, I was able to synthesize, optimize and debug non-equivalent point. The results are in the files:

- Netlist: **bound_flasher_m.v**

- Area report: **final_area.rpt**

- QoR report: **final_qor.rpt**

- Timing report: **final_rime.rpt**

- Debuging non-equivalent point: **Debug_non_equivalent_point.pdf**
