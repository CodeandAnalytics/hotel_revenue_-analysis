CREATE TABLE Hotel_reservation(
Booking_ID VARCHAR(15) PRIMARY KEY NOT NULL,
no_of_adults INT NOT NULL,
no_of_children	INT NOT NULL,
no_of_weekend_nights INT NOT NULL,	
no_of_week_nights INT NOT NULL,
type_of_meal_plan VARCHAR(20) NOT NULL,	
room_type_reserved VARCHAR(20) NOT NULL,
lead_time INT NOT NULL,
arrival_date DATE NOT NULL,	
market_segment_type VARCHAR(20) NOT NULL,
avg_price_per_room DECIMAL(10,2) NOT NULL,
booking_status VARCHAR(20) NOT NULL
)

SELECT * FROM Hotel_reservation

SELECT booking_id, 
       room_type_reserved,
	   arrival_date,
	   market_segment_type,
	   avg_price_per_room,
	   booking_status
FROM Hotel_reservation
WHERE booking_status = 'Not_Canceled' 


SELECT market_segment_type,
       SUM(avg_price_per_room) AS revenue_generated
FROM Hotel_reservation
GROUP BY market_segment_type
ORDER BY revenue_generated DESC;


WITH AvgMarketSegment AS (
    SELECT 
        market_segment_type, 
        ROUND(AVG(avg_price_per_room), 2) AS avg_price
    FROM Hotel_reservation
    GROUP BY market_segment_type
)
SELECT * FROM AvgMarketSegment;


SELECT booking_status ,COUNT(*) AS Status
FROM Hotel_reservation
WHERE booking_status ='Canceled' OR booking_status ='Not_Canceled'
GROUP BY booking_status 

SELECT 
    booking_status,COUNT(*) AS total_bookings,
    SUM(avg_price_per_room) AS total_revenue
FROM Hotel_reservation
WHERE booking_status IN ('Canceled', 'Not_Canceled')
GROUP BY booking_status;

SELECT 
    SUM(CASE WHEN booking_status = 'Not_Canceled' THEN avg_price_per_room ELSE 0 END) AS total_profit,
    SUM(CASE WHEN booking_status = 'Canceled' THEN avg_price_per_room ELSE 0 END) AS total_loss,
    (SUM(CASE WHEN booking_status = 'Not_Canceled' THEN avg_price_per_room ELSE 0 END) - 
    SUM(CASE WHEN booking_status = 'Canceled' THEN avg_price_per_room ELSE 0 END)) AS net_profit
FROM Hotel_reservation;


SELECT 
    ROUND(AVG(CASE WHEN booking_status = 'Not_Canceled' THEN avg_price_per_room ELSE 0 END),2) AS Avg_profit,
    ROUND(AVG(CASE WHEN booking_status = 'Canceled' THEN avg_price_per_room ELSE 0 END),2) AS Avg_loss
FROM Hotel_reservation;


SELECT room_type_reserved, 
SUM(avg_price_per_room) AS total_revenue_generated_per_room
FROM Hotel_reservation
GROUP BY room_type_reserved
ORDER BY total_revenue_generated_per_room DESC
LIMIT 3

WITH AvgPricePerRoomType AS (
    SELECT
        room_type_reserved, 
        ROUND(AVG(avg_price_per_room),2) AS avg_price
    FROM Hotel_reservation
    GROUP BY room_type_reserved
)
SELECT * FROM AvgPricePerRoomType;


	 










