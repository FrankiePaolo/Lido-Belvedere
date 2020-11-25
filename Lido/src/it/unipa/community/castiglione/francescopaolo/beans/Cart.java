package it.unipa.community.castiglione.francescopaolo.beans;

import it.unipa.community.castiglione.francescopaolo.utils.DBMSHandler;
import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Map<Integer, Integer> items_quantity;
    private Map<Integer, String > items_names;
    private Map<Integer, Float> items_prices;

    /* LinkedHashMap is a Hash table and linked list implementation of the Map interface 
	 * with predictable iteration order
	 */
    public Cart(){
        this.items_quantity = new LinkedHashMap<>();
        this.items_names = new LinkedHashMap<>();
        this.items_prices = new LinkedHashMap<>();
    }

    public Cart(Map<Integer, Integer> items_quantity){
        for (int i : items_quantity.keySet()){
            setItem_quantity(i, items_quantity.get(i));
        }
    }

    public Map<Integer, Integer> getItems_quantity() {
        return items_quantity;
    }

    public Map<Integer, String> getItems_names() {
        return items_names;
    }

    public void setItems_names(Map<Integer, String> items_names) {
        this.items_names = items_names;
    }

    public Map<Integer, Float> getItems_prices() {
        return items_prices;
    }

    public void setItems_prices(Map<Integer, Float> items_prices) {
        this.items_prices = items_prices;
    }

    /**
     * Any non-positive amount will remove the item,  if the item is already
     * in the cart its quantity will be updated, if it's a new item it will be
     * added to the cart only if there is a corresponding entry in the database.
     *
     * item is the id of the product to be added to the cart
     * param is the amount The selected amount to put in the cart
     */
    public void setItem_quantity(Integer item, Integer amount){
        if(amount > 0){
            if(items_names.containsKey(item) && items_prices.containsKey(item)){
            	items_quantity.put(item, amount);
            } else {
                float price = DBMSHandler.getItemPrice(item);
                String name = DBMSHandler.getItemName(item);

                if (price > 0 && !name.equals("")) {
                	items_quantity.put(item, amount);
                    items_prices.put(item, price);
                    items_names.put(item, name);
                }
            }
        } else {
        	items_quantity.remove(item);
        }
    }

    // Gets the quantity of the specified item
    public int getItem_quantity(Integer item){
        return items_quantity.get(item);
    }

    /* Sums the prices times the quantity of each product in the cart , returns 
     * the total cost of the contents of the cart up to the second decimal digit
     */
    public float getTotal(){
        float total = 0;
        for(int i: getItems_quantity().keySet()){
            total+= getItem_quantity(i)*getItems_prices().get(i);
        }
        return (float) (Math.round(total*100.0)/100.0);
    }

    /**
     * Clears all the data in the cart
     */
    public void emptyCart(){
    	items_quantity.clear();
        items_prices.clear();
        items_names.clear();
    }

}
