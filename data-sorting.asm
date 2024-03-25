include "emu8086.inc"   ;Library "emu8086.inc" will be used in this program"                                   

org 100h                                                    
gotoxy 8,0                                                  ;Go to row 0, colum 8 to print next line"
printn "Data sorting algorithm"                             ;Print the text in quotes to the screen.
printn "==================***=================="           
printn "How many elements in array of data?"                
print "size = "                                             
call scan_num           ;Call scan_num procedure to enter number of elements in array of data from keyboard.
mov i, cx               ;Store the entered number to the variable i.

printn                                  ;Print a blank line
printn                                  
print "Please input array elements:"   ;Print the text in quotes to the screen.

input_array:                            ;Input array label.
    mov dx, cx                          ;Move cx (number of loops) to dx to store number of loops remain.
    printn
    print "data["                       ;Print index number to screen.
    call print_num                      ;Call print_num procedure.
    print "] = "
    call scan_num                       ;Enter data from the keyboard.
    inc ax                              ;Increase the index number.
    mov a[bp], cl                       ;Move the entered data to array a.
    inc bp                              ;Increase the index registers to store the next data value.
    mov cx, dx                          ;Move dx to cx to excute the next loop. 
    loop input_array
    
print_input_array:                      ;Print input array label.
    printn                              ;Print a blank line. 
    printn
    printn "Input data:"                ;Print the text in quotes to the screen.
    mov cx, i                           ;Move data stored in variable i to cx for loop.
    mov bp, 0                           ;Reset the index register to 0 to start print data from begin.
    print_input:                        ;Print label.
        mov ah, 0                       ;Reset ah to 0 to ensure that there is no error while print_num excuting.
        mov al, a[bp]                   ;Move data from array a to al to print to the screen.
        call print_num                  ;Call print_num procedure.
        print " "                       ;Print space.
        inc bp                          ;Increase index register bp to print next data in array a.
        loop print_input                ;Loop print_input until cx = 0.

mov bp, 0                               ;Reset the index register bp to 0.
mov cx, i                               ;Move value in i to cx for loop.
sort_loop:                              ;Sort loop label.
    dec cx                              ;Decrease cx.
    cmp cx, bp                          ;Compare cx with bp.
    jle print_sorted_array              ;If cx <= bp -> jump to print_sorted_array label.
    
    compare_swap:                       ;compare and swap label.
        cmp bp, cx                      ;Compare bp with cx.
        jge sort_loop                   ;If bp >= cx -> jump to sort_loop label.
        
        mov bl, a[bp]                   ;Move data from array a at bp to bl for comparasion.
        mov bh, a[bp+1]                 ;Move data from array a at bp+1 to bh for comparasion.
        cmp bl, bh                      ;Compare bl with bh.
        jle increase                    ;If bl <= bh -> jump to increase label.
                                        ;IF NOT, SWAP BH VS BL:
        mov a[bp], bh                   ;Value in bh will be moved to a[bp].
        mov a[bp+1], bl                 ;Value in bl will be moved to a[bp+1].
        dec bp                          ;Decrease bp.
        
        jmp compare_swap                ;Jump to compare and swap label to continue loop.

increase:                               ;Increase label.
    inc bp                              ;Increase bp for next data value.
    jmp compare_swap                    ;Jump to compare and swap label to continue loop.
            
print_sorted_array:                     ;Print sorted data to the screen.
    mov bp, 0                           ;Reset index register bp to 0.
    mov cx, i                           ;Move value in i to cx for loop.
    printn                              ;Print a blank line.
    printn
    printn "Sorted data:"               ;Print the text in quotes to the screen.
    print_output:                       ;Print output lable.
        mov ah, 0                       ;Reset ah to 0 to ensure that there is no error while print_num excuting.
        mov al, a[bp]                   ;Move data from array a to al to print to the screen.
        call print_num                  ;Call print_num procedure.
        print " "                       ;Print space.
        inc bp                          ;Increase bp to print next data value in array a.
        loop print_output               ;Loop print_output until cx = 0. 
exit:                                   ;Exit label.
    ret                                 ;End program.
                                        ;Define some procedures will use in this program:
DEFINE_SCAN_NUM                         ;Procedure to let user enter the number from the keyboard.
DEFINE_PRINT_NUM                        ;Procedure to print the number to the screen.    
DEFINE_PRINT_NUM_UNS                    ;Procedure to print the unsigned number to the screen.

i dw 0                                  ;Declare variable i to store number of loops.
a db 0 dup(100)                         ;Declare array a.
