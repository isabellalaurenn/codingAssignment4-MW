//memoryTB.v
`timescale 1ns/1ps

module memory_tb();
    
    reg clk;
    reg [31:0] ALUResult, WriteData;
    reg [4:0] WriteReg;
    reg [1:0] WBControl;
    reg MemWrite, MemRead, Branch, Zero;
    wire [31:0] ReadData, ALUResult_out;
    wire [4:0] WriteReg_out;
    wire MEM_WB_regwrite, MEM_WB_memtoreg;
    wire PCSrc;
    wire [31:0] write_data_out; // added to test writeback.v functionality
    
    memory uut (
        .clk(clk),
        // Everything below was updated to match memory.v naming
        .alu_result(ALUResult),
        .rdata2out(WriteData),
        .five_bit_muxout(WriteReg), // changed to the input
        .wb_ctlout(WBControl),
        .memwrite(MemWrite),
        .memread(MemRead),
        .branch(Branch),
        .zero(Zero),
        .read_data(ReadData),
        .mem_alu_result(ALUResult_out),
        .mem_write_reg(WriteReg_out),
        .MEM_WB_regwrite(MEM_WB_regwrite), // added
        .MEM_WB_memtoreg(MEM_WB_memtoreg), // also added!
        .MEM_PCSrc(PCSrc)
    );

    // tests writeback.v functionality
    writeback wb_test (
        .mem_to_reg(MEM_WB_memtoreg),
        .read_data(ReadData),
        .mem_alu_result(ALUResult_out),
        .write_data(write_data_out)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        // Mem Read
        // LW from address 4 (DMEM[4] = 4)
        ALUResult = 32'h00000004;
        WriteData = 32'h12345678;
        WriteReg = 5'h02;
        WBControl = 2'b01;
        MemWrite = 0;
        MemRead = 1;
        Branch = 0;
        Zero = 0;
        
        #10; 
        
        // Mem Write
        // SW (store 12345678 into DMEM[4])
        WBControl = 2'b00;
        MemWrite = 1;
        MemRead = 0;
        #10; 
        
        // Allow write to occur
        // LW again to read the stored value back
        WBControl = 2'b11;
        MemWrite = 0;
        MemRead = 1;
        #10; // Verify write by reading back
        
        // Branch
        // branch taken (branch is 1, zero is 1)
        Branch = 1;
        Zero = 1;
        #10; // Check PCSrc

        //adding more test cases
        //branch not taken
        Zero = 0;
        #10;

        //zero set but not a branch instruction
        Branch = 0;
        Zero = 1;
        #10;
        
        $finish;
    end
endmodule
