`timescale 1ns/1ps

// APB interface
interface apb_if(input logic clk);

    logic        psel;
    logic        penable;
    logic        pwrite;
    logic [7:0]  paddr;
    logic [7:0]  pwdata;
    logic [7:0]  prdata;
    logic        pready;

    logic        start;
    logic        write_cmd;
    logic [7:0]  addr_cmd;
    logic [7:0]  wdata_cmd;

    logic        done;
    logic [7:0]  rdata_cmd;

    modport master (
        input  clk, start, write_cmd, addr_cmd, wdata_cmd,
              prdata, pready,
        output psel, penable, pwrite, paddr, pwdata,
               done, rdata_cmd
    );

    modport slave (
        input  clk, psel, penable, pwrite, paddr, pwdata,
        output prdata, pready
    );

endinterface


// APB Master
module apb_master(apb_if.master apb);

    typedef enum logic [1:0] {
        IDLE,
        SETUP,
        ACCESS
    } state_t;

    state_t state;

    always @(posedge apb.clk) begin

        case (state)

            IDLE: begin
                apb.psel    <= 1'b0;
                apb.penable <= 1'b0;
                apb.done    <= 1'b0;

                if (apb.start) begin
                    apb.paddr  <= apb.addr_cmd;
                    apb.pwdata <= apb.wdata_cmd;
                    apb.pwrite <= apb.write_cmd;
                    state <= SETUP;
                end
            end

            SETUP: begin
                apb.psel    <= 1'b1;
                apb.penable <= 1'b0;
                state <= ACCESS;
            end

            ACCESS: begin
                apb.psel    <= 1'b1;
                apb.penable <= 1'b1;

                if (apb.pready) begin

                    if (!apb.pwrite)
                        apb.rdata_cmd <= apb.prdata;

                    apb.done    <= 1'b1;
                    apb.psel    <= 1'b0;
                    apb.penable <= 1'b0;

                    state <= IDLE;
                end
            end

            default: state <= IDLE;

        endcase
    end

    initial begin
        state         = IDLE;
        apb.psel      = 1'b0;
        apb.penable   = 1'b0;
        apb.pwrite    = 1'b0;
        apb.paddr     = 8'h00;
        apb.pwdata    = 8'h00;
        apb.done      = 1'b0;
        apb.rdata_cmd = 8'h00;
    end

endmodule


// APB Slave
module apb_slave(apb_if.slave apb);

    logic [7:0] mem [0:255];

    initial begin
        apb.prdata = 8'h00;
        apb.pready = 1'b0;

        for (int i = 0; i < 256; i = i + 1)
            mem[i] = 8'h00;
    end

    always @(posedge apb.clk) begin

        apb.pready <= 1'b0;

        if (apb.psel && apb.penable) begin

            apb.pready <= 1'b1;

            if (apb.pwrite)
                mem[apb.paddr] <= apb.pwdata;
            else
                apb.prdata <= mem[apb.paddr];

        end
    end

endmodule


// Top module
module apb_top;

    logic clk;

    apb_if apb(clk);

    apb_master master (
        .apb(apb)
    );

    apb_slave slave (
        .apb(apb)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

endmodule