function guess_output_bits = viterbi_decode(input_bits, type)
    if type == 'hard'
        path_weight = 0;
        %path_length = 8;
        output_bits    = zeros(1, length(input_bits)/2);
        
        %output_trail   = zeros(length(input_bits)/2, path_length);
        previous_stage  = zeros(1, 2);
        output_trail_n = 1;
        
        viterbi_row     = 0;
        viterbi_path(1,:) = [0 0 0 0]; %[weight, decoded_bit, rx_bit0, rx_bit1]
        
        for bit = 1:2:length(input_bits)
            if previous_stage == [0 0]
                previous_stage = input_bits(bit:bit+1);
                
                if input_bits(bit:bit+1) == [0 0]
                    
                    viterbi_row = viterbi_row + 1;
                    viterbi_path(viterbi_row,:) = [path_weight 0 0 0]
                    
                    %output_row = output_row + 1;
                    %guess_output_bits  (output_row, :) = [0]
                    %guess_output_weight(output_row, :) = path_weight
                    
                    %output_trail_n = output_trail_n + 1;
                    %output_trail(output_trail_n, :) = [0 path_weight] %[bit value, weight]
                    
                    %output_bits((bit + 1)/2) = 0;
                elseif input_bits(bit:bit+1) == [1 1]
                    
                    viterbi_row = viterbi_row + 1;
                    viterbi_path(viterbi_row,:) = [path_weight 1 0 0]
                    
                    %output_row = output_row + 1;
                    %guess_output_bits  (output_row, :) = [1]
                    %guess_output_weight(output_row, :) = path_weight
                    
                    %output_trail_n = output_trail_n + 1;
                    %output_trail(output_trail_n, :) = [1 path_weight] %[bit value, weight]
                    
                    %output_bits((bit + 1)/2) = 1;
                else
                    path_weight = path_weight + 1;
                    
                    viterbi_row = viterbi_row + 1;
                    viterbi_path(viterbi_row,:) = [path_weight 0 0 0]
                    
                    viterbi_row = viterbi_row + 1;
                    viterbi_path(viterbi_row,:) = [path_weight 1 0 0]                    
                    
                    %output_row = output_row + 1;
                    %guess_output_bits  (output_row, :) = [0]
                    %guess_output_weight(output_row, :) = path_weight
                    
                    %output_row = output_row + 1;
                    %guess_output_bits  (output_row, :) = [1]
                    %guess_output_weight(output_row, :) = path_weight
                    
                    %output_trail_n = output_trail_n + 1;
                    %output_trail(output_trail_n, :) = [0 path_weight] %[bit value, weight]
                    
                    %output_trail_n = output_trail_n + 1;
                    %output_trail(output_trail_n, :) = [1 path_weight] %[bit value, weight]
                end
                
            elseif previous_stage == [0 1]
                previous_stage = input_bits(bit:bit+1);
                
                if input_bits(bit:bit+1) == [0 0]
                    viterbi_row = viterbi_row + 1;
                    viterbi_path(viterbi_row,:) = [path_weight 1 0 1]
                    
                    %output_trail_n = output_trail_n + 1;
                    %output_trail(output_trail_n, :) = [1 path_weight] %[bit value, weight]
                elseif input_bits(bit:bit+1) == [1 1]
                    viterbi_row = viterbi_row + 1;
                    viterbi_path(viterbi_row,:) = [path_weight 0 0 1]
                    
                    %output_trail_n = output_trail_n + 1;
                    %output_trail(output_trail_n, :) = [0 path_weight] %[bit value, weight]
                else
                    path_weight = path_weight + 1;
                    
                    viterbi_row = viterbi_row + 1;
                    viterbi_path(viterbi_row,:) = [path_weight 0 0 1]
                    
                    viterbi_row = viterbi_row + 1;
                    viterbi_path(viterbi_row,:) = [path_weight 1 0 1]
                end
                
            elseif previous_stage == [1 0]
                previous_stage = input_bits(bit:bit+1);
                
                if input_bits(bit:bit+1) == [0 1]
                    viterbi_row = viterbi_row + 1;
                    viterbi_path(viterbi_row,:) = [path_weight 0 1 0]
                    
                elseif input_bits(bit:bit+1) == [1 0]
                    viterbi_row = viterbi_row + 1;
                    viterbi_path(viterbi_row,:) = [path_weight 1 1 0]
                else
                    path_weight = path_weight + 1;
                    
                    viterbi_row = viterbi_row + 1;
                    viterbi_path(viterbi_row,:) = [path_weight 0 1 0]
                    
                    viterbi_row = viterbi_row + 1;
                    viterbi_path(viterbi_row,:) = [path_weight 1 1 0]
                end
                
            elseif previous_stage == [1 1]
                previous_stage = input_bits(bit:bit+1)
                
                if input_bits(bit:bit+1) == [0 1]
                    viterbi_row = viterbi_row + 1;
                    viterbi_path(viterbi_row,:) = [path_weight 1 1 1]
                elseif input_bits(bit:bit+1) == [1 0]
                    viterbi_row = viterbi_row + 1;
                    viterbi_path(viterbi_row,:) = [path_weight 0 1 1]
                else
                    path_weight = path_weight + 1;
                    
                    viterbi_row = viterbi_row + 1;
                    viterbi_path(viterbi_row,:) = [path_weight 0 1 1]
                    
                    viterbi_row = viterbi_row + 1;
                    viterbi_path(viterbi_row,:) = [path_weight 1 1 1]
                end

            end

        end
    elseif type == 'soft'
        return
    end
end