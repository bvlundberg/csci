/* Notes
for (i = my_rank; i < total; i += num_cores)
	sum += i



divisor = 2
core_diff = 1
sum = my_value
while(core_diff < num_cores)
{
	if(my_rank % divisor == 0)
	{
		partner = my_rank + core_diff
		receive from partner
		sum
	}
	else
	{
		partner = my_rank - core_diff
		send to partner
	}
	core_diff *= 2
	divisor *= 2
}

when num processes != 2^x, check to see if partner exists