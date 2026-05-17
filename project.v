`timescale 1ns / 1ps

module project (
    input  wire        clk,
    input  wire        rst,

    // AHB
    input  wire [31:0] ahb_addr,
    input  wire [31:0] ahb_data_in,
    output reg  [31:0] ahb_data_out,
    input  wire        ahb_write,
    input  wire        ahb_read,
    input  wire        ahb_valid,
    input  wire [2:0]  ahb_size,
    input  wire [2:0]  ahb_burst,
    input  wire        ahb_lock,
    input  wire        ahb_prot,

    // APB
    output reg  [31:0] apb_addr,
    output reg  [31:0] apb_data_out,
    input  wire [31:0] apb_data_in,
    output reg         apb_write,
    output reg         apb_read,
    output reg         psel,
    output reg         penable,

    // Status
    output reg         ahb_ready,
    output reg         apb_ready
);

    // FSM
    localparam IDLE        = 2'b00,
               SETUP       = 2'b01,
               ACCESS      = 2'b10,
               ACCESS_HOLD = 2'b11;

    reg [1:0] state;

    // Latched AHB
    reg [31:0] addr_r, data_r;
    reg        write_r, read_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            psel <= 0; penable <= 0;
            apb_write <= 0; apb_read <= 0;
            ahb_ready <= 0; apb_ready <= 0;
            ahb_data_out <= 0;
        end else begin
            ahb_ready <= 0;
            apb_ready <= 0;

            case (state)

            IDLE: begin
                psel <= 0; penable <= 0;
                if (ahb_valid) begin
                    addr_r  <= ahb_addr;
                    data_r  <= ahb_data_in;
                    write_r <= ahb_write;
                    read_r  <= ahb_read;
                    ahb_ready <= 1;      // AHB = 1 cycle
                    state <= SETUP;
                end
            end

            SETUP: begin
                psel <= 1;
                penable <= 0;
                apb_addr <= addr_r;
                apb_data_out <= data_r;
                apb_write <= write_r;
                apb_read  <= read_r;
                state <= ACCESS;
            end

            ACCESS: begin
                psel <= 1;
                penable <= 1;
                apb_ready <= 1;
                if (read_r)
                    ahb_data_out <= apb_data_in;
                state <= ACCESS_HOLD;
            end

            ACCESS_HOLD: begin
                // HOLD signals so monitor can see them
                psel <= 1;
                penable <= 1;
                apb_write <= 0;
                apb_read  <= 0;
                state <= IDLE;
            end

            endcase
        end
    end
endmodule
