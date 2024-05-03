package mypackage;

import java.sql.Timestamp;

public class Bid {
  public final int ID;
  public double amount;
  public Timestamp timestamp;
  
  public boolean autoBiddingEnabled;
  public double autoBiddingLimit;

  public int bidderID;
  public String bidderUsername;

  public Bid (int ID, double amount, Timestamp timestamp, boolean autoBiddingEnabled, double autoBiddingLimit, int bidderID, String bidderUsername) {
    this.ID = ID;
    this.amount = amount;
    this.timestamp = timestamp;

    this.autoBiddingEnabled = autoBiddingEnabled;
    this.autoBiddingLimit = autoBiddingLimit;
    
    this.bidderID = bidderID;
    this.bidderUsername = bidderUsername;
  }
}
