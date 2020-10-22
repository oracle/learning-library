package com.dom.benchmarking.swingbench.transactions;


public class ProductDetails {

    double price;
    int productID;
    int quantityAvailable;
    int warehouseID;

    public double getPrice() {
        return price;
    }

    public int getProductID() {
        return productID;
    }

    public int getQuantityAvailable() {
        return quantityAvailable;
    }

    public int getWarehouseID() {
        return warehouseID;
    }


    public ProductDetails(int pid, int wid, int qo) {
        productID = pid;
        warehouseID = wid;
        quantityAvailable = qo;
    }

}
