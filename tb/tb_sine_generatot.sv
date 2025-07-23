`timescale 1ns/1ps

module tb_sine_generator;

    localparam CLK_PERIOD = 10;
    localparam SIM_CYCLES = 2;
  localparam SIM_TIME   = (100000 * 100000 * SIM_CYCLES);

    logic clk;
    logic rst;
    logic [7:0] sine_out;

    sine_generator dut (
        .clk      (clk),
        .rst      (rst),
        .sine_out (sine_out)
    );

    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    initial begin
        $display("Testbench: Starting simulation.");

        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_sine_generator);

        rst = 1;
        $display("Testbench: Reset is Asserted.");
        #(CLK_PERIOD * 5);
        
        rst = 0;
        $display("Testbench: Reset is De-asserted. Sine wave generation will start.");

        #SIM_TIME;
        
        $display("Testbench: Simulation finished.");
        $finish;
    end

endmodule```
