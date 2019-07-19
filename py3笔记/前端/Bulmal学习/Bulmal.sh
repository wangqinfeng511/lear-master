index.html 设置：
<head>
    <meta charset="UTF-8">
    <title>ToDO</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.2.3/css/bulma.min.css">
     <!--<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css">-->
</head>
############################################################################################################
布局：
  <div className="tile is-ancestor"> #引入类
                {/*<div className="tile is-vertical is-8">*/}
                <div className="tile is-vertical  is-10"> #is-number 代表占总页面的百分比
                    <div className="tile">
                        <div className="tile is-parent is-vertical ">
                        <article className="tile is-child notification is-primary">
                            <p className="title">Vertical...</p>
                            <p className="subtitle">Top tile</p>
                        </article>
                            <article className="tile is-child notification is-warning">
                                <p className="title">...tiles</p>
                                <p className="subtitle">Bottom tile</p>
                            </article>
                            <div className="tile is-parent">
                                <article className="tile is-child notification is-info">
                                    <p className="title"> Middle tile</p>
                                    <p className="subtitle">With an image</p>
                                    <figure className="image is-4by3">
                                        <image src="http://192.168.12.105:3001/img/小丑.jpg"></image>
                                    </figure>
                                </article>
                            </div>
                        </div>
                        <div className="tile is-parent">
                            <article className="tile is-child notification is-danger">
                                <p className="title"> Wide tile</p>
                                <p className="subtitle"> Aligned with the right tile</p>
                                <div className="content">
                                    hesadfil kie  fkd
                                </div>
                            </article>
                        </div>
                    </div>
                    <div className="tile is-parent">
                        <article className="tile is-child notification is-success">
                            <p className="title"> Tall tile</p>
                            <p className="subtitle"> With even more content</p>
                            <div>
                                asdfasdfsdfadfasdfdf
                            </div>
                        </article>

                    </div>
                </div>
            </div>
