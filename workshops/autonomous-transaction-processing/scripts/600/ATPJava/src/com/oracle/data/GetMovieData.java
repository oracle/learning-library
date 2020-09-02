package com.oracle.data;

import java.io.IOException;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.HttpClientBuilder;

public class GetMovieData {
	
	public String getMovieData() {
		
		try {
			HttpClient client = HttpClientBuilder.create().build();
			HttpGet getRequest = new HttpGet(
				"http://www.omdbapi.com/?apikey=1349eeac&y=2018");
			getRequest.addHeader("accept", "application/json");
			HttpResponse response = client.execute(getRequest);
			String responseString = new BasicResponseHandler().handleResponse(response);
			System.out.println(responseString);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		new GetMovieData().getMovieData();
	}

}
