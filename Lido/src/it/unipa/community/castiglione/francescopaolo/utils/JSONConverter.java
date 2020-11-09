package it.unipa.community.castiglione.francescopaolo.utils;

import it.unipa.community.castiglione.francescopaolo.beans.Cart;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.Set;

public class JSONConverter {
	
	//This method iterates through the items in the ResultSet object and returns a JSONArray
	static JSONArray resultSetToArray(ResultSet resultSet) throws SQLException{
		JSONArray array=new JSONArray();
		try {
			while(resultSet.next()) {
				array.put(resultSetToObject(resultSet));
			}
		}catch(JSONException e) {
			e.printStackTrace();
		}
		return array;
	}
	
	//This methods converts a ResultSet object into a JSONObject
	static JSONObject resultSetToObject(ResultSet resultSet) throws SQLException{
		JSONObject object =new JSONObject();
		try {
			//getMetaData retrieves the number, types and properties of this ResultSet object's columns
			int n_columns=resultSet.getMetaData().getColumnCount();
			for(int i=1;i<=n_columns;i++) {
				String label=resultSet.getMetaData().getColumnLabel(i);
				object.put(label, resultSet.getObject(i));
			}
		} catch(JSONException e) { 
			e.printStackTrace();
		}
		return object;
	}
	
	//This method converts a Cart into a JSONArray
	public static JSONArray cartToArray(Cart cart){
        JSONArray arr = new JSONArray();
        Map<Integer, Integer> items_amount = cart.getItemsAmount();
        Map<Integer, String> items_names = cart.getItems_names();
        Map<Integer, Float> items_prices = cart.getItems_prices();
        Set<Integer> ids = items_amount.keySet();
        try {
            for (int id: ids  ) {
                JSONObject obj = new JSONObject();
                obj.put("id",id);
                obj.put("amount",items_amount.get(id));
                obj.put("name",items_names.get(id));
                obj.put("price",items_prices.get(id));

                arr.put(obj);
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return arr;
    }
	
}


