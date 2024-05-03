package mypackage;

import java.sql.Timestamp;
import java.util.List;

public class Item {
  public final int ID;
  public String name;
  public String category;

  public List<Bid> bids;
  public double reservePrice;
  public double bidIncrement;

  public Timestamp openDate;
  public Timestamp closeDate;

  public int sellerID;
  public String sellerUsername;

  public Item (int ID, String name, String category, List<Bid> bids, double reservePrice, double bidIncrement, Timestamp openDate, Timestamp closeDate, int sellerID, String sellerUsername) {
    this.ID = ID;
    this.name = name;
    this.category = category;
    
    this.bids = bids;
    this.reservePrice = reservePrice;
    this.bidIncrement = bidIncrement;

    this.openDate = openDate;
    this.closeDate = closeDate;

    this.sellerID = sellerID;
    this.sellerUsername = sellerUsername;
  }
}
