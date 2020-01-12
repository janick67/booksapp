class Order {
  constructor(order) {
    console.log('id')
    this.id = order.details.id
    console.log('customer')
    this.customerID = ifExsistElse(order.details.customer.id)
    console.log('source')
    this.sourceWarehouseID = ifExsistElse(order.details.sourceWarehouse.id)
    console.log('target')
    this.targetWarehouseID = ifExsistElse(order.details.targetWarehouse.id)
    console.log('status')
    this.status = ifExsistElse(order.details.status)
    console.log('address')
    this.addressID = ifExsistElse(order.details.address.id)
    console.log('shipment')
    this.shipmentID = ifExsistElse(order.details.shipment.id)
    console.log('store')
    this.sumGross = ifExsistElse(order.sumGross)
    console.log('store')
    this.storeID = ifExsistElse(order.details.store.id)
    console.log('user')
    this.userID = ifExsistElse(order.details.user.id)
    this.books = order.selectedBooks
  }

  getBooks(){
    let booksID = []
    this.books.forEach(el => booksID.push(el.id))
    return booksID
  }

  writeToSql(writeSql){
    return new Promise(async (resolve, reject) => {
      if (this.sourceWarehouseID == null) { console.error('nie podano magazynu źródłowego'); return -1; }
      if (this.customerID == null && this.targetWarehouseID == null) { console.error('nie podano magazynu docelowego ani kontrahenta'); return -1; }

      let sqlOrder = `INSERT INTO orders(or_customerID, or_sourceWarehouseID, or_targetWarehouseID, or_status, or_addressID, or_shipmentID, or_storeID, or_creatorID, or_modID, or_comment,or_sumGross)
                  VALUES (${this.customerID},${this.sourceWarehouseID},${this.targetWarehouseID}, ${this.status}, ${this.addressID}, ${this.shipmentID}, ${this.storeID}, ${this.userID}, ${this.userID}, "",${this.sumGross})`
      await writeSql(sqlOrder).then(resp  => {
        this.id = resp.insertId
      }).catch(error => {console.error(error); reject(error)});

      this.books.forEach(el => {
        el.sql = `INSERT INTO order_books(ob_orderID, ob_bookID, ob_count, ob_manualDiscount)
                                            VALUES (${this.id},${el.id},${el.count},${ifExsistElse(el.manualDiscount,0)});`
      })
      console.log(sqlOrder,'\n\n');
      console.log(this.books,'\n\n');
      this.books.forEach((el,i) => {
        writeSql(el.sql).then(resp  => {
           this.books.sqlId = resp.insertId
        }).catch(error => {console.error(error); reject(error)});
        if (this.books.length -1 == i) resolve(this);
      })
    })
  }
}

function ifExsistElse(one, two = null){
  if (typeof one !== 'undefined' && one !== null)  return one
  return two
}

module.exports = Order
