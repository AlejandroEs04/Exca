import { ChangeEvent, Dispatch, SetStateAction, useState } from "react"
import { CaseConditionCreate, Condition, Project } from "../../types"

type ConditionsContainerType = {
    conditionsList: Condition[]
    newConditions: CaseConditionCreate[]
    setNewConditions: Dispatch<SetStateAction<CaseConditionCreate[]>>
    project: Project
    isNotGrid?: boolean
    isChecked?: boolean
    handleGetValue: (id: number) => string | number | boolean | undefined
}

export default function ConditionsContainer({ 
    conditionsList, 
    newConditions,
    setNewConditions,
    isNotGrid = false,
    isChecked = false,
    handleGetValue
} : ConditionsContainerType) {
    const [inputChecked, setInputChecked] = useState(false)
    const [inputCheckedMap, setInputCheckedMap] = useState<Record<number, boolean>>({});

    const handleChange = (e: ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
        const { value, name } = e.target as HTMLInputElement | HTMLSelectElement;
        const checked = (e.target as HTMLInputElement).checked;

        const condition = conditionsList.find(c => c.name === name);
        // Find by condition_id, not id
        const existsCondition = newConditions.find(c => c.condition_id === condition?.id);

        const conditionCreate : CaseConditionCreate = {
            condition_id: condition?.id!, 
            text_value: condition?.type_id === 1 ? value : undefined, 
            number_value: condition?.type_id === 2 ? +value : undefined,
            date_value: condition?.type_id === 3 ? value : undefined, 
            boolean_value: condition?.type_id === 4 ? checked : undefined,
            option_id: condition?.type_id === 5 ? +value : undefined,
            is_active: true
        }

        if (existsCondition) {
            setNewConditions(newConditions.map(c => c.condition_id !== condition?.id ? c : conditionCreate))
        } else {
            setNewConditions([...newConditions, conditionCreate])
        }
    }

    const toggleInputChecked = (id: number, checked: boolean) => {
        setInputCheckedMap(prev => ({ ...prev, [id]: checked }));
    };

    return (
        <div className={!isNotGrid ? "conditions-list" : ''}>
            {conditionsList.map(condition => (
                <div className='condition-container g-2' key={condition.id}>
                    <label htmlFor={condition.id.toString()}>{condition.name}</label>

                    {condition.type_id === 1 && (
                        <>
                            {isChecked ? (
                                <div className="flex items-center g-2">
                                    <div className='checkbox w-min m-0'>
                                        <input onChange={(e) => setInputChecked(e.target.checked)} type='checkbox' />
                                        <span className="checkmark"></span>
                                    </div>
                                    <input className="w-full" disabled={!inputChecked} value={handleGetValue(condition.id) as string | number} onChange={handleChange} type='text' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                                </div>
                            ) : (
                                <input value={handleGetValue(condition.id) as string} onChange={handleChange} type='text' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                            )}
                        </>
                    )}
                    {condition.type_id === 2 && (
                        <input value={handleGetValue(condition.id) as number} onChange={handleChange} type='number' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                    )}
                    {condition.type_id === 3 && (
                        <input value={handleGetValue(condition.id) as string} onChange={handleChange} type='date' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                    )}
                    {condition.type_id === 4 && (
                        <div className='checkbox'>
                            <input checked={handleGetValue(condition.id) as boolean} onChange={e => { handleChange(e); toggleInputChecked(condition.id, e.target.checked) }} type='checkbox' name={condition.name} id={condition.id.toString()} placeholder={condition.name} />
                            <span className="checkmark"></span>

                            <p>{`${inputCheckedMap[condition.id] ?? false ? 'Si' : 'No'}`}</p>
                        </div>
                    )}
                    {condition.type_id === 5 && (
                        <select value={handleGetValue(condition.id) as number} onChange={handleChange} name={condition.name} id={condition.id.toString()}>
                            <option value="">Selecciona una opción</option>
                            {condition.options?.map(option => (
                                <option value={option.id} key={option.id}>{option.option_value}</option>
                            ))}
                        </select>
                    )}
                </div>
            ))}
        </div>
    )
}
