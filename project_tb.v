`timescale 1ns / 1ps
module project_tb;

    reg clk;
    reg rst;

    reg  [31:0] ahb_addr;
    reg  [31:0] ahb_data_in;
    wire [31:0] ahb_data_out;
    reg         ahb_write;
    reg         ahb_read;
    reg  [2:0]  ahb_size;
    reg  [2:0]  ahb_burst;
    reg         ahb_lock;
    reg         ahb_prot;
    reg         ahb_valid;

    wire [31:0] apb_addr;
    wire [31:0] apb_data_out;
    wire [31:0] apb_data_in;
    wire        apb_write;
    wire        apb_read;
    wire        psel;
    wire        penable;

    wire ahb_ready;
    wire apb_ready;

    // Slave signals
    wire [31:0] slave0_data, slave1_data;
    wire        slave0_ready, slave1_ready;
    wire sel_slave0, sel_slave1;

    // Address decoding
    assign sel_slave0 = (apb_addr[31:16] == 16'h0000);
    assign sel_slave1 = (apb_addr[31:16] == 16'h0001);

    assign apb_ready   = (sel_slave0) ? slave0_ready : (sel_slave1) ? slave1_ready : 0;
    assign apb_data_in = (sel_slave0) ? slave0_data : (sel_slave1) ? slave1_data : 32'h0000;
	 initial begin
		$dumpfile("project.vcd");
		$dumpvars(0, project_tb);
    end
    // Clock
    initial clk = 0;
    always #5 clk = ~clk;

    // Reset
    initial begin
        rst = 1; #20 rst = 0;
    end

    // DUT
    project dut (
        .clk(clk),
        .rst(rst),
        .ahb_addr(ahb_addr),
        .ahb_data_in(ahb_data_in),
        .ahb_data_out(ahb_data_out),
        .ahb_write(ahb_write),
        .ahb_read(ahb_read),
        .ahb_size(ahb_size),
        .ahb_burst(ahb_burst),
        .ahb_lock(ahb_lock),
        .ahb_prot(ahb_prot),
        .ahb_valid(ahb_valid),
        .apb_addr(apb_addr),
        .apb_data_out(apb_data_out),
        .apb_data_in(apb_data_in),
        .apb_write(apb_write),
        .apb_read(apb_read),
        .psel(psel),
        .penable(penable),
        .ahb_ready(ahb_ready),
        .apb_ready(apb_ready)
    );

    // Instantiate 2 different slaves
    apb_memory slave0 (
        .PCLK(clk),
        .PRESETn(rst),
        .PADDR(apb_addr),
        .PWDATA(apb_data_out),
        .PWRITE(apb_write & sel_slave0),
        .PSEL(psel & sel_slave0),
        .PENABLE(penable),
        .PRDATA(slave0_data),
        .PREADY(slave0_ready)
    );

    apb_memory slave1 (
        .PCLK(clk),
        .PRESETn(rst),
        .PADDR(apb_addr),
        .PWDATA(apb_data_out),
        .PWRITE(apb_write & sel_slave1),
        .PSEL(psel & sel_slave1),
        .PENABLE(penable),
        .PRDATA(slave1_data),
        .PREADY(slave1_ready)
    );

    // Simulation
    initial begin
        ahb_addr    = 0; ahb_data_in = 0;
        ahb_write   = 0; ahb_read = 0; ahb_valid = 0;
        ahb_size    = 3'b010; ahb_burst = 3'b000; ahb_lock = 0; ahb_prot = 0;

        @(negedge rst);
		  $display("\n AHB to APB write");
		  

        // Write Slave0
        $display("\nWRITE SLAVE0");
        ahb_addr = 32'h0000_1000;
        ahb_data_in = 32'hAAAA1111;
        ahb_write = 1; ahb_valid = 1;
        #10 ahb_write = 0; ahb_valid = 0; #20;

        // Write Slave1
        $display("\nWRITE SLAVE1");
        ahb_addr = 32'h0001_1000;
        ahb_data_in = 32'hBBBB2222;
        ahb_write = 1; ahb_valid = 1;
        #10 ahb_write = 0; ahb_valid = 0; #20;
		  $display("\nAHB to APB read");
        // Read Slave0
        $display("\nREAD SLAVE0");
        ahb_addr = 32'h0000_1000; ahb_read = 1; ahb_valid = 1;
        #10 ahb_read = 0; ahb_valid = 0; #20;
        $display("SLAVE0 DATA = %h", ahb_data_out);

        // Read Slave1
        $display("\nREAD SLAVE1");
        ahb_addr = 32'h0001_1000; ahb_read = 1; ahb_valid = 1;
        #10 ahb_read = 0; ahb_valid = 0; #20;
        $display("SLAVE1 DATA = %h", ahb_data_out);

        $display("\nSIMULATION COMPLETED SUCCESSFULLY");
        #10 $finish;
    end

    // Monitor
    always @(posedge clk) begin
        if (psel && penable) begin
            if (sel_slave0) begin
                if (apb_write) $display("[%0t ns] APB WRITE -> SLAVE0 Addr=%h Data=%h", $time, apb_addr, apb_data_out);
                if (apb_read)  $display("[%0t ns] APB READ  -> SLAVE0 Addr=%h Data=%h", $time, apb_addr, slave0_data);
            end
            else if (sel_slave1) begin
                if (apb_write) $display("[%0t ns] APB WRITE -> SLAVE1 Addr=%h Data=%h", $time, apb_addr, apb_data_out);
                if (apb_read)  $display("[%0t ns] APB READ  -> SLAVE1 Addr=%h Data=%h", $time, apb_addr, slave1_data);
            end
        end
    end
endmodule
