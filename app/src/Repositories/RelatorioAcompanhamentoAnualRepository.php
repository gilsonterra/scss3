<?php

namespace App\Repositories;

use App\Models\ViewRelAnalitico;
use App\Models\AcompanhamentoCategoria;
use App\Models\AcompanhamentoItem;
use Illuminate\Database\Capsule\Manager as DB;

final class RelatorioAcompanhamentoAnualRepository extends BaseRepository
{
    /**
     * @var ViewRelAnalitico
     */
    protected $model;

    /**
     *
     * @var AcompanhamentoItem
     */
    protected $modelItem;

    /**
     * Constructor
     *
     * @param ViewRelAnalitico $model
     * @param AcompanhamentoItem $modelItem
     */
    public function __construct(ViewRelAnalitico $model, AcompanhamentoItem $modelItem)
    {
        $this->model = $model;
        $this->modelItem = $modelItem;
    }


    public function fetchAll(array $where = array())
    {
        $query = $this->model->newQuery();
        $string = "
            SELECT
                categoria,
                item,
                SUM(DECODE(mes,1,total,0)) mes_1,
                SUM(DECODE(mes,2,total,0)) mes_2,
                SUM(DECODE(mes,3,total,0)) mes_3,
                SUM(DECODE(mes,4,total,0)) mes_4,
                SUM(DECODE(mes,5,total,0)) mes_5,
                SUM(DECODE(mes,6,total,0)) mes_6,
                SUM(DECODE(mes,7,total,0)) mes_7,
                SUM(DECODE(mes,8,total,0)) mes_8,
                SUM(DECODE(mes,9,total,0)) mes_9,
                SUM(DECODE(mes,10,total,0)) mes_10,
                SUM(DECODE(mes,11,total,0)) mes_11,
                SUM(DECODE(mes,12,total,0)) mes_12,
                SUM(total) total_anual
            FROM
                (
                    SELECT
                        ac.descricao categoria,
                        ai.descricao item,
                        TO_CHAR(a.data_cadastro,'MM') mes,
                        CASE WHEN a.data_cadastro IS NOT NULL THEN COUNT(*) ELSE 0 END  total
                    FROM
                        tbl_acompanhamento_categoria ac
                        INNER JOIN tbl_acompanhamento_item ai 
                            ON ai.fk_categoria_acompanhamento = ac.codigo
                        LEFT JOIN tbl_acompanhamento a ON a.fk_acompanhamento = ai.codigo
                            AND a.fk_local = :fk_local
                            AND TO_CHAR(a.data_cadastro,'yyyy') = :ano
                            AND a.status = 1
                    GROUP BY
                        ac.descricao,
                        ai.descricao,
                        a.data_cadastro
                )
            GROUP BY
                categoria,
                item
            ORDER BY
                categoria,
                item";


        $pdo = DB::getPdo();
        $statement = $pdo->prepare($string);
        $statement->setFetchMode(\PDO::FETCH_ASSOC);
        $statement->execute([
            'fk_local' => $where['fk_local'],
            'ano' => $where['ano']
        ]);
                        
        $data = $statement->fetchAll();
        $dataF = [];
        $dataF2 = [];
        foreach($data as $key => $value){
            $id = sha1($value['categoria']);
            $dataF[$id]['descricao'] = $value['categoria'];
            $dataF[$id]['acompanhamento_item'][] = $value; 
            $dataF[$id]['totalizadores']['total_anual'] += $value['total_anual'];
            
            for($i = 1; $i <= 12; $i++){
                $mes = 'mes_' . $i;
                $dataF[$id]['totalizadores'][$mes] += $value[$mes]; 
            }            
        }

        foreach($dataF as $d){
            $dataF2[] = $d;
        }

        return $dataF2;
    }
}
