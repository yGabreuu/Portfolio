import plotly.graph_objects as go
import plotly.offline as pyo
def grafico_barra(x_barra,y_barra):
    fig  = go.Figure(layout=go.Layout(width=600, height=400))
    fig.add_trace(
        go.Bar(
            x= x_barra, y= y_barra, marker_color='#400c0c'
        )
    )
    fig.update_layout(
        title = 'Grafico em barra',
        xaxis_title = 'Modelo trabalho',
        yaxis_title = 'Quantidade de pessoas',
        plot_bgcolor = '#2d3142',
        paper_bgcolor= '#2d3142',
        font = dict(color='white')
    )
    pyo.init_notebook_mode(connected=True)
    pyo.iplot(fig)