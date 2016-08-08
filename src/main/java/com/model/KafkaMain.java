package com.model;

import java.io.IOException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

public class KafkaMain{
	public static void main(String[] args) throws IOException
	{

		MyFeeds rss = new MyFeeds();
		rss.getFeeds(rss.getFeedUrl("http://www.theverge.com/"));

		/*	Producer producerThread  = new Producer("test1", true);
			Consumer consumerThread = new Consumer("test1");

			ExecutorService executor = Executors.newFixedThreadPool(1);
			executor.submit(consumerThread);	

			Runtime.getRuntime().addShutdownHook(new Thread() {
				@Override
				public void run() {
					consumerThread.shutdown();
					executor.shutdown();
					try {
						executor.awaitTermination(5000, TimeUnit.MILLISECONDS);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			});
			producerThread.run();
			producerThread.close();*/

	}
}
