`timescale 1ns/1ps

module apb_tb;

    apb_top dut();

    virtual apb_if.master vif;

    task apb_write(
        input [7:0] addr,
        input [7:0] data
    );

        @(posedge dut.clk);

        vif.addr_cmd  <= addr;
        vif.wdata_cmd <= data;
        vif.write_cmd <= 1'b1;
        vif.start     <= 1'b1;

        @(posedge dut.clk);

        vif.start <= 1'b0;

        wait(vif.done == 1'b1);

        $display(
            "WRITE: address = %h, data = %h",
            addr, data
        );

        @(posedge dut.clk);

    endtask


    task apb_read(
        input [7:0] addr
    );

        @(posedge dut.clk);

        vif.addr_cmd  <= addr;
        vif.wdata_cmd <= 8'h00;
        vif.write_cmd <= 1'b0;
        vif.start     <= 1'b1;

        @(posedge dut.clk);

        vif.start <= 1'b0;

        wait(vif.done == 1'b1);

        $display(
            "READ: address = %h, data = %h",
            addr, vif.rdata_cmd
        );

        @(posedge dut.clk);

    endtask


    initial begin
        $dumpfile("apb.vcd");
        $dumpvars(0, apb_tb);
    end


    initial begin

        vif = dut.apb;

        vif.start     = 1'b0;
        vif.write_cmd = 1'b0;
        vif.addr_cmd  = 8'h00;
        vif.wdata_cmd = 8'h00;

        #10;

        apb_write(8'h00, 8'h25);

        apb_read(8'h00);

        #20;

        $display("--------------------------------");
        $display("APB TEST COMPLETED");
        $display("--------------------------------");

        $finish;

    end

endmodule