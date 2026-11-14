// writeback.v - implements the writeback stage of the MIPS pipeline by using a mux to select what is written back to regFile
module writeback(
    input wire mem_to_reg, // mem_to_reg is the select line
    input wire [31:0] read_data, // 32-bit value retrieved from data memory
    input wire [31:0] mem_alu_result, // 32-bit alu result from pervious stage
    output wire [31:0] write_data // 32-bit data that is to be written back to regFile
);

assign write_data = mem_to_reg ? read_data : mem_alu_result; // if (mem_to_reg) {write_data = read_data} else {write_data = mem_alu_result}

endmodule
