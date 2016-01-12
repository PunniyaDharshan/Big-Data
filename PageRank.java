package page;

import java.io.IOException;
import java.io.*;

public class PageRank {

	public static void main(String ar[])throws IOException
	{
	float iteration,no_of_nodes,rank[],sub_rank[],initial_rank[],out[],
	value[][];
	int i,j,n;
	DataInputStream d=new DataInputStream(System.in);  
	System.out.println("Enter the number of Iterations and nodes");
	iteration=Float.parseFloat(d.readLine());
	no_of_nodes=Float.parseFloat(d.readLine());
	value=new float[(int) no_of_nodes][(int) no_of_nodes];
	rank=new float[(int) no_of_nodes];
	sub_rank=new float[(int) no_of_nodes];
	out=new float[(int) no_of_nodes];
	initial_rank=new float[(int) no_of_nodes];
	System.out.println("Enter the values of each link");
	
	/*Assigning Initial Rank Values */
	for(i=0;i<no_of_nodes;i++)
	{
		initial_rank[i]=1/no_of_nodes;
		out[i]=0;
		sub_rank[i]=0;
	}
	
	/*Assigning node links */
	for(i=0;i<no_of_nodes;i++)
	{
	for(j=0;j<no_of_nodes;j++)
	{
		value[i][j]=Integer.parseInt(d.readLine());
	}
	}
	/*Calculating outgoing node Values */
	for(i=0;i<no_of_nodes;i++)
	{
		for(j=0;j<no_of_nodes;j++)
		{
			if(value[i][j]==1)
			{
				out[j]=out[j]+1;
			}
		}
	}
	
	/*Compute Page rank Values */  
	for(n=0;n<no_of_nodes;n++)
	{
		System.out.println("Below are the values of "+n+" Iteration");
		
		/*Initial Iteration*/
		if(n==0)
		{
			for(i=0;i<no_of_nodes;i++)
			{
				for(j=0;j<no_of_nodes;j++)
				{
					if(value[i][j]==1)
					{
						sub_rank[i]=sub_rank[i]+initial_rank[j]/out[j];
					}
				}
			}
			for(i=0;i<no_of_nodes;i++)
			{
				rank[i]=initial_rank[i]/no_of_nodes+(1-initial_rank[i])*(sub_rank[i]);
				System.out.println("Node "+i+"="+rank[i]);
			}
		}
		/*Computing the other iteration except the first*/
		else
		{
			for(i=0;i<no_of_nodes;i++)
			{
				initial_rank[i]=rank[i];
				sub_rank[i]=0;
			}
			for(i=0;i<no_of_nodes;i++)
			{
				for(j=0;j<no_of_nodes;j++)
				{
					if(value[i][j]==1)
					{
						sub_rank[i]=sub_rank[i]+initial_rank[j]/out[j];
					}
				}
			}
			for(i=0;i<no_of_nodes;i++)
			{
				rank[i]=initial_rank[i]/no_of_nodes+(1-initial_rank[i])*(sub_rank[i]);
				System.out.println("Rank of Node "+i+"="+rank[i]);
				System.out.println("Outgoing links for node "+i+"="+out[i]);
			}
		}
	}
	}
}
