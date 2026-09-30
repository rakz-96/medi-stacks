USE hospital_system;
DROP TRIGGER IF EXISTS trg_bill_item_after_insert;
DROP TRIGGER IF EXISTS trg_bill_item_after_update;
DROP TRIGGER IF EXISTS trg_bill_item_after_delete;
DROP TRIGGER IF EXISTS trg_payment_after_insert;
DROP TRIGGER IF EXISTS trg_payment_after_update;
DELIMITER $$
CREATE TRIGGER trg_bill_item_after_insert AFTER INSERT ON bill_item FOR EACH ROW BEGIN UPDATE bill SET subtotal=(SELECT COALESCE(SUM(amount),0) FROM bill_item WHERE bill_id=NEW.bill_id),tax=(SELECT COALESCE(SUM(amount),0) FROM bill_item WHERE bill_id=NEW.bill_id)*0.05,total_amount=(SELECT COALESCE(SUM(amount),0) FROM bill_item WHERE bill_id=NEW.bill_id)*1.05 WHERE bill_id=NEW.bill_id; END$$
CREATE TRIGGER trg_bill_item_after_update AFTER UPDATE ON bill_item FOR EACH ROW BEGIN UPDATE bill SET subtotal=(SELECT COALESCE(SUM(amount),0) FROM bill_item WHERE bill_id=NEW.bill_id),tax=(SELECT COALESCE(SUM(amount),0) FROM bill_item WHERE bill_id=NEW.bill_id)*0.05,total_amount=(SELECT COALESCE(SUM(amount),0) FROM bill_item WHERE bill_id=NEW.bill_id)*1.05 WHERE bill_id=NEW.bill_id; END$$
CREATE TRIGGER trg_bill_item_after_delete AFTER DELETE ON bill_item FOR EACH ROW BEGIN UPDATE bill SET subtotal=(SELECT COALESCE(SUM(amount),0) FROM bill_item WHERE bill_id=OLD.bill_id),tax=(SELECT COALESCE(SUM(amount),0) FROM bill_item WHERE bill_id=OLD.bill_id)*0.05,total_amount=(SELECT COALESCE(SUM(amount),0) FROM bill_item WHERE bill_id=OLD.bill_id)*1.05 WHERE bill_id=OLD.bill_id; END$$
CREATE TRIGGER trg_payment_after_insert AFTER INSERT ON payment FOR EACH ROW BEGIN UPDATE bill SET status=CASE WHEN (SELECT COALESCE(SUM(amount),0) FROM payment WHERE bill_id=NEW.bill_id)>=total_amount THEN 'PAID' WHEN (SELECT COALESCE(SUM(amount),0) FROM payment WHERE bill_id=NEW.bill_id)>0 THEN 'PARTIALLY_PAID' ELSE 'UNPAID' END WHERE bill_id=NEW.bill_id; END$$
CREATE TRIGGER trg_payment_after_update AFTER UPDATE ON payment FOR EACH ROW BEGIN UPDATE bill SET status=CASE WHEN (SELECT COALESCE(SUM(amount),0) FROM payment WHERE bill_id=NEW.bill_id)>=total_amount THEN 'PAID' WHEN (SELECT COALESCE(SUM(amount),0) FROM payment WHERE bill_id=NEW.bill_id)>0 THEN 'PARTIALLY_PAID' ELSE 'UNPAID' END WHERE bill_id=NEW.bill_id; END$$
DELIMITER ;
