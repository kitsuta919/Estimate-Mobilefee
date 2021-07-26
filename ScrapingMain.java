
import java.io.*;


import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class ScrapingMain{
    public static void main(String[] args) throws IOException {
	
	String url = "https://kakaku.com/keitai/article/iphone/carrier.html";
	Document doc = null;
	// FileWriter f = new FileWriter("Sample.csv",false);
	PrintWriter p = new PrintWriter(new BufferedWriter(new OutputStreamWriter(new FileOutputStream("Sample.csv"),"Shift-JIS")));
	
	doc = Jsoup.connect(url).get();
	
	// System.out.println(doc);
	String tdstr,title;
	for(Element table : doc.select("table")){
	    table.select("div").remove();
	    table.select("br").append(" ");
	    for(Element row : table.select("tr")){
		Elements tds = row.select("td");
		Elements ths = row.select("th");
		
		//title= ths.get(0).text()+","+ths.get(1).text()+","+ths.get(2).text()+","+ths.get(3).text()+","+"\n";
		//System.out.println(tdstr);
		
		if(tds.size()>1){
		    tdstr = "";
		    tdstr+="' "+ths.get(0).text().replace("～","")+ " '"+",";
		    for(int i=0;i<=2;i++){
			tdstr+= "' "+tds.get(i).text().replaceAll(",","")+ " '"+",";
		    }
		    //tdstr = ths.get(0).text()+","+tds.get(0).text().replaceAll(",","")+","+tds.get(1).text().replaceAll(",","")+","+tds.get(2).text().replaceAll(",","")+","+"\n";
		    tdstr +="\n";
		    p.print(tdstr);
		    
		}else{
		    title ="";
		    for(int j=0;j<=3;j++){
			title += "' "+ths.get(j).text()+" '"+",";
			
		    }
		    title +="\n";
		    p.print(title);
		}
	    }
	    
	    //p.print(title);
	}
	//p.print(thstr);
	p.close();
    }
    
    
}

