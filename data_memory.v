/*Instantiates and serves as the data mememory. 
Its inputs are alu_result, rdata2out, memwrite, and memread, which stem from the EX/MEM latch.
The output, read_data, goes to the MEM/WB latch. 
If memread is true, then read_data is re-assigned as the value in current address. If memwrite is true,
then read_data is unaltered, and instead, the value in the current address is changed to rdata2out. 
*/
module data_memory (
    input wire [31:0] addr, // Memory Address
    input wire [31:0] write_data, // Memory Address Contents
    input wire memread, memwrite, // refer to Lab 2-2 Figure 2.2
    output reg [31:0] read_data // Output of Memory Address Contents
);
    // Register Declaration
    reg [31:0] DMEM[0:255];  // 256 (2^8) words of 32-bit memory
    integer i;
    
    initial begin
        // DMEM[0-255] = 0-255 first so every word has a known value
        for ( = 0; i < 256; i++)
            DMEM[i] = i;
        // DMEM[0-5] from data.txt
        $readmemb("data.txt", DMEM, 0, 5);
        for (i = 0; i < 6; i++)
            $display("\tDMEM[%0d] = %0b", i, DMEM[i]);
    end

    //store happens on clock edge
    always @(posedge clk) begin
        if (memread) // load
            DMEM[addr] <= write_data; //writes data to the address specificed by addr
    end

    //load is combinational so the word is ready for the MEM/WB latch on clock edge

    assign read_data = memread ? DMEM[addr] : 32'b0;
endmodule // data_memory
