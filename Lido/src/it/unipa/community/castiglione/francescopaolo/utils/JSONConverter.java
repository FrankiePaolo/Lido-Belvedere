package it.unipa.community.castiglione.francescopaolo.utils;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.sql.ResultSet;
import java.sql.SQLException;

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
	
	
	
}


