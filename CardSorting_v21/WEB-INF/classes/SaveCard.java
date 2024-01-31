import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.gson.Gson; 
import com.google.gson.GsonBuilder; 

@SuppressWarnings("serial")
@WebServlet(name = "Card", urlPatterns = {"/Card"})
public class SaveCard extends HttpServlet {

    String homPath = "";

    @SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request,
        HttpServletResponse response) throws ServletException, IOException {
            HttpSession session = request.getSession(true);
            try{
                int sis = (int) session.getAttribute("SIS");
                int previous = Integer.parseInt(request.getParameter("Previous"));
                String sortingType = request.getParameter("SortingType");
                ArrayList<Card> cards = (ArrayList<Card>) session.getAttribute("Cards");
                int sorting, orderIndex;
                ArrayList<Integer> order;

                if (sortingType.equals("Comfort")){
                    sorting = (int) session.getAttribute("CardSortingStatus");
                    orderIndex = (int) session.getAttribute("CurrentCard");
                    order = (ArrayList<Integer>) session.getAttribute("CardOrder");
                }else{
                    response.setContentType("text/plain");
                    response.setStatus(HttpServletResponse.SC_NO_CONTENT);
                    PrintWriter writer = response.getWriter();
                    writer.println("Invalid Request");
                    writer.close();
                    return;
                }

                Card card = getCard(sis, sorting, previous, orderIndex, order, cards, sortingType);
                CardProgress retObj = new CardProgress(card,orderIndex,order.size());

                if(card == null){
                    response.setContentType("text/plain");
                    response.setStatus(HttpServletResponse.SC_NO_CONTENT);
                    PrintWriter writer = response.getWriter();
                    writer.println("Invalid Request");
                    writer.close();
                }else if(card.getName().equals("Done")){
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    PrintWriter writer = response.getWriter();
                    GsonBuilder builder = new GsonBuilder();
                    builder.setPrettyPrinting();
                    Gson gson = builder.create();

                    String output = gson.toJson(retObj);
                    writer.println(output);
                    writer.close();
                }else if(card.getName().equals("NoChanges")){
                    response.setContentType("text/plain");
                    PrintWriter writer = response.getWriter();
                    writer.println("This acitivity is complete. You can't make any changes.");
                    writer.close();
                }else{
                    int cardIndex = getCardIndex(previous, orderIndex, order);
                    if(cardIndex == -1){
                        cards.set(cardIndex, card);
                        session.setAttribute("Cards",cards);
                    }
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    
                    PrintWriter writer = response.getWriter();
                    GsonBuilder builder = new GsonBuilder();
                    builder.setPrettyPrinting();
                    Gson gson = builder.create(); 

                    String output = gson.toJson(retObj);
                    writer.println(output);
                    writer.close();
                }
            }catch(Exception e){
            	Logger logger = Logger.getLogger(this.getClass().getName());
                logger.log(Level.WARNING, e.getMessage());
                
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.setContentType("text/plain");
                PrintWriter writer = response.getWriter();
                //writer.println("An error has occured.");
                e.printStackTrace(writer);
                writer.close();
            }

    }
	
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
				
                HttpSession session = request.getSession(true);
                try{
                    int sis = (int) session.getAttribute("SIS");

                    String regex = "^\\s+";
                    String stackName = request.getParameter("SortedInto").replaceAll(regex, "");
                    String path = request.getParameter("Path");
                    String sortingType = request.getParameter("SortingType");
                    //Logger logger = Logger.getLogger(this.getClass().getName());
                    //logger.log(Level.INFO, path);
                    int CardSortingStatus = -1;
                    if(sortingType.equals("Comfort")){
                        CardSortingStatus = (int) session.getAttribute("CardSortingStatus");
                    }

                    if (sis == 1 && CardSortingStatus == 0){
                        ArrayList<Integer> order = (ArrayList<Integer>) session.getAttribute("CardOrder");
                        int orderIndex = (int) session.getAttribute("CurrentCard");
                        ArrayList<Card> cards = (ArrayList<Card>) session.getAttribute("Cards");
                        int cardIndex = order.get(orderIndex);

                        Card card = updateCard(orderIndex, order, cards, stackName, path);

                        cards.set(cardIndex, card);
                        session.setAttribute("Cards",cards);

                        if(order.size() == orderIndex+1){
                            session.setAttribute("CardSortingStatus",1);
                        }
                        orderIndex += 1;
                        session.setAttribute("CurrentCard",orderIndex);
                        
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        PrintWriter writer = response.getWriter();
                        
                        GsonBuilder builder = new GsonBuilder();
                        builder.setPrettyPrinting();
                        Gson gson = builder.create();
                        
                        String output = gson.toJson(card);
                        writer.println(output);
                        writer.close();
                        
                    }else{
                        response.setContentType("text/plain");
                        PrintWriter writer = response.getWriter();
                        writer.println("Invalid Request");
                        writer.close();
                    }
                }catch(Exception e){
                	Logger logger = Logger.getLogger(this.getClass().getName());
                    logger.log(Level.WARNING, e.getMessage());
                    
                    response.setContentType("text/plain");
                    PrintWriter writer = response.getWriter();
                    writer.println("An error has occured.");
                    e.printStackTrace(writer);
                    writer.close();
                }
    }

    private Card getCard(int sis, int sorting, int previous, int orderIndex, ArrayList<Integer> order, ArrayList<Card> cards, String sortingType){

        if(sis == 1 && sorting == 0 && previous == 0 && sortingType.equals("Comfort")){
            int cardIndex = order.get(orderIndex);       
            Card card = cards.get(cardIndex);
            card.setStartTime(System.currentTimeMillis());
            return card;
        }else if(sis == 1 && (sorting  == 1 || sorting == 2) && previous == 0){
            String doneCategory = "None";
            Card done = new Card("Done","None");
            return done;
        }else if(sis == 1 && (sorting  == 0 || sorting == 1) && previous == 1 && orderIndex > 0){
            int prevCardIndex = order.get(orderIndex-1);       
            Card card = cards.get(prevCardIndex);
            return card;
        }else if(sis == 1 && sorting == 2 && previous == 1){
            String noMoreChangesCategory = "None";
            Card noMoreChanges = new Card("NoChanges","None");
            return noMoreChanges;
        }else{
            return null;
        }

    }

    private int getCardIndex(int previous, int orderIndex, ArrayList<Integer> order){
        if(previous == 1 && orderIndex > 0){
            return order.get(orderIndex-1);
        }else if(previous == 0){
            return order.get(orderIndex);
        }else{
            return -1;
        }
    }

    private Card updateCard(int orderIndex, ArrayList<Integer> order, ArrayList<Card> cards, String stackName, String path){
        int cardIndex = order.get(orderIndex);
        Card card = cards.get(cardIndex);
        card.setEndTime(System.currentTimeMillis());
        card.setStackName(stackName);
        card.setSortPath(path);
        return card;
    }
	
}