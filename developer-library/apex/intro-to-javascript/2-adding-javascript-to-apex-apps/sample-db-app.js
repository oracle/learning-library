function doWork() {
  console.log('doWork fired!');
}

function styleSalesByCatChart(options) {
  options.dataFilter = function(data) {
    data.series[0].color = '#0B6623';
    data.series[1].color = '#9DC183';
    data.series[2].color = '#708238';return data;
  };

  return options;
}
