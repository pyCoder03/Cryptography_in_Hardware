`timescale 1ns / 1ps

module S_DES_Encrypt#(parameter[39:0] P_10=40'h7583609124,P_8=40'h47362501,I_P=40'h62574031,I_P_1=40'h47531602,E_P=40'h03212103,P_4=40'h2013,[31:0] S_1=40'h4EE427DE,S_0=40'h1B87C493)(
    input [7:0] plaintext,
    input [9:0] Key_10,
    output [7:0] ciphertext
    );
    wire[7:0] w[0:3],K1,K2;
    
    Key_Generate#(P_10,P_8) Key_Gen(
        .key_10(Key_10),
        .K1(K1),
        .K2(K2)
    );
    
    Permute#(I_P,8) Init_Per(
        .bits_in(plaintext),
        .bits_out(w[0])
    );
    
    Function#(E_P,P_4,S_1,S_0) Func_1(
        .key(K1),
        .ip(w[0]),
        .op(w[1])
    );
    
    Switch_Halves#(8) SW(
        .s_in(w[1]),
        .s_out(w[2])
    );
    
    Function#(E_P,P_4,S_1,S_0) Func_2(
        .key(K2),
        .ip(w[2]),
        .op(w[3])
    );
    
    Permute#(I_P_1,8) Per_Inv(
        .bits_in(w[3]),
        .bits_out(ciphertext)
    );
endmodule
