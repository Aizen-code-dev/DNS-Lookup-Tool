package net;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class NetworkUtils {

    // Method to get HTTP response code
    public static int getHttpResponseCode(URL url) throws IOException {
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.connect();
        return connection.getResponseCode();
    }

    // Method to get DNS records (A records as an example)
    public static List<String> getDnsRecords(String host) {
        List<String> records = new ArrayList<>();
        try {
            InetAddress[] addresses = InetAddress.getAllByName(host);
            for (InetAddress address : addresses) {
                records.add("A Record: " + address.getHostAddress());
            }
        } catch (Exception e) {
            records.add("No DNS records found for " + host);
        }
        return records;
    }
}