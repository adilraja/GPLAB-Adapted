%/*********************
%*
%*	FUNCTION: move_pitch
%*
%*	DESCRIPTION:
%*		This function is used to move pitch marks which have caused inconsistencies in a
%*		particular voiced section. Also checks to see if the run of consistent pitch marks has
%*		been extended to the beginning of the voiced section and returns the correct value (1)
%*		if this happy situation has been reached.
%*
%***********************/
function finished=move_pitch(first_last, first_last_length, long_consist, long_consist_length, current_pitch, current_pitch_length, speech, pitch_allocated)

	loop;
    finished = 1 ;
    PITCH_CLOSE_TO_START=200;
	allocated = current_pitch_length ;

	for(loop=1:long_consist_length)
		first_last_search_result = bin_search_first_last(long_consist(loop).consist_left, first_last, *first_last_length);

		current_pitch_search_result = bin_search(long_consist(loop).consist_left, current_pitch, current_pitch_length);

		if((~isempty(first_last_search_result) && (long_consist(loop).consist_left > PITCH_CLOSE_TO_START))
			local_search_result=find_local_search_boundaries(current_pitch, current_pitch_search_result, speech, &previous_mark);
			tmp_index = bin_search(long_consist(loop).consist_left, current_pitch, current_pitch_length) ;
			element_to_remove = current_pitch[tmp_index - 1] ;

			if(bin_search(local_search_result, current_pitch, current_pitch_length)~=-1)
				insertion_point = bin_insert(previous_mark, current_pitch, current_pitch_length, pitch_allocated) ;
			else
				insertion_point = bin_insert(local_search_result, current_pitch, current_pitch_length, pitch_allocated) ;
            end
			if (tmp_index ~= insertion_point)
				bin_remove(element_to_remove, current_pitch, current_pitch_length ) ;
            end

			finished = 0 ;
        end
