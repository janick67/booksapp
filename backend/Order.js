class Order {
  constructor(order) {
    // console.log('id')
    this.id = order.details.id
    // console.log('customer')
    this.customerID = ifExsistElse(order.details.customer.id)
    // console.log('source')
    this.sourceWarehouseID = ifExsistElse(order.details.sourceWarehouse.id)
    // console.log('target')
    this.targetWarehouseID = ifExsistElse(order.details.targetWarehouse.id)
    // console.log('status')
    this.status = ifExsistElse(order.details.status)
    // console.log('address')
    this.addressID = ifExsistElse(order.details.address.id)
    // console.log('address')
    this.deliveryType = ifExsistElse(order.details.deliveryType)
    // console.log('shipment')
    this.shipmentID = ifExsistElse(order.details.shipment.id)
    // console.log('store')
    this.storeID = ifExsistElse(order.details.store.id)
    // console.log('user')
    this.userID = ifExsistElse(order.details.user.id)
    this.books = order.selectedBooks
  }

  getBooks(){
    let booksID = []
    this.books.forEach(el => booksID.push(el.id))
    return booksID
  }

  async sumUpPrices(){
    this.sumGross = 0;
    this.books.forEach(el=>{ this.sumGross += (el.price-(el.price*el.discount)) * el.count})
    this.sumGross -= (this.sumGross * this.discount);
    if (this.deliveryType == 'Kurier') this.sumGross += 10 // za kuriera
    this.sumNet = this.sumGross - (this.sumGross*(23/100))
  }

  async writeToSql(writeSql){

    if (this.sourceWarehouseID == null) { console.error('nie podano magazynu źródłowego'); return -1; }
    if (this.customerID == null && this.targetWarehouseID == null) { console.error('nie podano magazynu docelowego ani kontrahenta'); return -1; }

    let sqlOrder = `INSERT INTO orders(or_customerID, or_sourceWarehouseID, or_targetWarehouseID, or_status, or_addressID, or_shipmentID, or_storeID, or_creatorID, or_modID, or_comment)
                VALUES (${this.customerID},${this.sourceWarehouseID},${this.targetWarehouseID}, ${this.status}, ${this.addressID}, ${this.shipmentID}, ${this.storeID}, ${this.userID}, ${this.userID}, "")`
    await writeSql(sqlOrder).then(resp  => {
      this.id = resp.insertId
    })

    this.books.forEach(el => {
      el.sql = `INSERT INTO order_books(ob_orderID, ob_bookID, ob_count, ob_manualDiscount)
                                          VALUES (${this.id},${el.id},${el.count},0);`
    })

    // console.log(sqlOrder,'\n\n');
    // console.log(this.books,'\n\n');

    this.books.forEach(async (el,i) => {
      await writeSql(el.sql).then(resp  => {
          el.sqlId = resp.insertId
      })
      if (this.books.length-1 == i){
        //console.log('ostatnia pozycja', el);
      }
    })

  }
}

function ifExsistElse(one, two = null){
  if (typeof one !== 'undefined' && one !== null)  return one
  return two
}

module.exports = Order
