module sine_generator #(
    parameter SYS_CLK_FREQ = 50_000_000,
    parameter SINE_FREQ    = 1_000,
    parameter LUT_DEPTH    = 256,
    parameter DATA_WIDTH   = 8,
    
    localparam CLK_DIVIDER_LIMIT = SYS_CLK_FREQ / (SINE_FREQ * LUT_DEPTH) - 1,
    localparam ADDR_WIDTH = $clog2(LUT_DEPTH)
) (
    input  logic             clk,
    input  logic             rst,
    output logic [DATA_WIDTH-1:0] sine_out
);

    logic [ADDR_WIDTH-1:0]   address;
    logic                    tick;
    logic [DATA_WIDTH-1:0]   sine_data;

    logic [$clog2(CLK_DIVIDER_LIMIT):0] clk_divider_count;
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_divider_count <= 0;
        end else if (clk_divider_count >= CLK_DIVIDER_LIMIT) begin
            clk_divider_count <= 0;
        end else begin
            clk_divider_count <= clk_divider_count + 1;
        end
    end
    
    assign tick = (clk_divider_count == CLK_DIVIDER_LIMIT);
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            address <= 0;
        end else if (tick) begin
            address <= address + 1;
        end
    end
    
    // ---  Sine Wave ROM (Look-Up Table) ---
    // This combinational block acts as our Read-Only Memory.
    // It maps the current 'address' to a pre-calculated sine value.
    
    // ** PASTE THE OUTPUT FROM THE PYTHON SCRIPT HERE **
    
    always_comb begin
        case (address)
            8'd0: sine_data = 8'd128;
            8'd1: sine_data = 8'd131;
            8'd2: sine_data = 8'd134;
            // ... all 256 entries ...
            8'd255: sine_data = 8'd125;
            default: sine_data = 8'd128; // Middle value
        endcase
    end
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            sine_out <= 0;
        end else begin
            sine_out <= sine_data;
        end
    end

endmodule
