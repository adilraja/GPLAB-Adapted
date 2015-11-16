%/*********************
%*
%*	FUNCTION: bin_search
%*
%*	DESCRIPTION:
%*		Embedded of bin_search() function.
%*		Search for a specified value in a sorted array (use bin_query).
%*
%***********************/
function ptr=bin_search( INT32 value, INT32 * list_array, INT32 Nelements )

    %although this function should have done a binary search, we use
    %MATLAB's find function to return the first index of the searchable
    %entry from the specified array.
    
    i=find(list_array(1:Nelements)==value);
    if isempty(i)
        ptr=-1;
    else
        ptr=i(1);
    end
